{
  lib,
  config,
  headless,
  ...
}:
with lib; let
  cfg = config.module.security;
in {
  options = {
    module.security = {
      enable = mkEnableOption "Enables security";
      enableBootOptions = mkEnableOption "Enables boot options";
      disableIPV6 = mkEnableOption "Disable ipv6";
    };
  };

  config = mkIf cfg.enable {
    security = {
      sudo.enable = false;

      pam.services = optionalAttrs (!headless) {
        hyprlock = {};
      };

      sudo-rs = {
        enable = true;
        execWheelOnly = true;
        wheelNeedsPassword = true;
      };

      polkit = optionalAttrs (!headless) {
        enable = true;
        extraConfig = ''
          polkit.addRule(function(action, subject) {
            if (subject.isInGroup("wheel") && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )) {
              return polkit.Result.YES;
            }
          });
        '';
      };
    };
    systemd.user.services.polkit-gtk = {
      description = "Polkit authentication agent";

      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];

      script = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    boot = optionalAttrs cfg.enableBootOptions {
      kernelParams =
        [
          # Security settings
          "debugfs=off"
          "page_alloc.shuffle=1"
          "page_poison=1"
          "slab_nomerge"
        ]
        ++ optionals cfg.disableIPV6 [
          # Disable ipv6
          "ipv6.disable=1"
        ];

      blacklistedKernelModules = [
        # Obscure network protocols
        "ax25"
        "netrom"
        "rose"

        # Old or rare or insufficiently audited filesystems
        "adfs"
        "affs"
        "bfs"
        "befs"
        "cramfs"
        "efs"
        "erofs"
        "exofs"
        "freevxfs"
        "f2fs"
        "hfs"
        "hpfs"
        "jfs"
        "minix"
        "nilfs2"
        "ntfs"
        "omfs"
        "qnx4"
        "qnx6"
        "sysv"
        "ufs"
      ];

      kernel.sysctl =
        {
          # Hide kptrs even for processes with CAP_SYSLOG`
          "kernel.kptr_restrict" = 2;

          # Disable ftrace debugging
          "kernel.ftrace_enabled" = false;

          # Enable strict reverse path filtering (that is, do not attempt to route
          # packets that "obviously" do not belong to the iface's network; dropped
          # packets are logged as martians).
          "net.ipv4.conf.all.log_martians" = true;
          "net.ipv4.conf.all.rp_filter" = "1";
          "net.ipv4.conf.default.log_martians" = true;
          "net.ipv4.conf.default.rp_filter" = "1";

          # Ignore broadcast ICMP (mitigate SMURF)
          "net.ipv4.icmp_echo_ignore_broadcasts" = true;

          # Ignore incoming ICMP redirects (note: default is needed to ensure that the
          # setting is applied to interfaces added after the sysctls are set)
          "net.ipv4.conf.all.accept_redirects" = false;
          "net.ipv4.conf.all.secure_redirects" = false;
          "net.ipv4.conf.default.accept_redirects" = false;
          "net.ipv4.conf.default.secure_redirects" = false;
          "net.ipv6.conf.all.accept_redirects" = false;
          "net.ipv6.conf.default.accept_redirects" = false;

          # Ignore outgoing ICMP redirects (this is ipv4 only)
          "net.ipv4.conf.all.send_redirects" = false;
          "net.ipv4.conf.default.send_redirects" = false;
        }
        // optionalAttrs cfg.disableIPV6 {
          # Disable ipv6
          "net.ipv6.conf.all.disable_ipv6" = true;
          "net.ipv6.conf.default.disable_ipv6" = true;
          "net.ipv6.conf.lo.disable_ipv6" = true;
          "net.ipv6.conf.tun0.disable_ipv6" = true;
        };
    };
  };
}
