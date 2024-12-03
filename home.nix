{
  inputs,
  config,
  pkgs,
  ...
}: {
  # # You may split your configuration into many files. If so, list them in imports.
  # # Also imports can be used for enabling programs added with flakes.
  imports = [
    ./hypr/hyprland.nix
    ./hypr/hyprlock.nix
    ./hypr/hyprpaper.nix
    ./themes/gtk.nix
    #./themes/stylix.nix
    ./shell/starship.nix
    ./shell/fish.nix
    ./shell/tmux.nix
    ./editors/neovim.nix
    ./editors/vscode.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "Sk7Str1p3";
  home.homeDirectory = "/home/Sk7Str1p3";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    firefox
    kitty
    blender
    yazi
    hyprshot
    hyprpicker
    hyprsunset
    hyprlock
    hyprpaper
    yazi
    gimp
    nixfmt-rfc-style
    blender
    vesktop
    git-credential-manager
    firefox
    nixfmt-rfc-style
    kitty
    figlet
    nautilus
    rofi-wayland
    rofi-power-menu
    hyprshot
    python313Full
    gimp
    swaybg
    wine-staging
    steam
    python312Packages.python-lsp-server
    luajitPackages.lua-lsp
    lldb_19
    python312Packages.debugpy
    obs-studio
    gnome-disk-utility
    udisks
    hyprlock
    zapret
    obsidian
    gcc
    gdb
    python313Full
    any-nix-shell
    pywal16
    nix-output-monitor
    inputs.ags.packages.${pkgs.system}.io
    inputs.ags.packages.${pkgs.system}.battery
    mypy
    direnv
    times-newer-roman

    inputs.ayugram.packages.${pkgs.system}.ayugram-desktop

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (nerdfonts.override {
      fonts = [
        "Iosevka"
        "JetBrainsMono"
      ];
    })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # You can enable systemd units per-user (actually nuhuh you cant. very sad((()
  #  services.ollama = {
  #    enable = true;
  #    acceleration = "cuda";
  #  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  # Also, to directly manage ~/.config/ folder, "xdg.configFile" can be used.

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/Sk7Str1p3/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Some themes (e.g. Catppuccin) provides its own modules for NixOS
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    pointerCursor = {
      enable = true;
      accent = "mauve";
      flavor = "mocha";
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-mocha-mauve-cursors";
    size = 24;
  };

  # Set xdg user directories:
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Many programs can be configured with home-manager modules.
  # For configuration options, check
  # https://nix-community.github.io/home-manager/

  programs.ags = {
    enable = true;
    configDir = ./non-nix/ags;
  };
  programs.git = {
    package = pkgs.gitFull;
    enable = true;
    extraConfig = {
      credential = {
        helper = "manager";
        credentialStore = "secretservice";
      };
      user = {
        email = "finenkofedor@gmail.com";
        name = "Sk7Str1pe";
      };
    };
  };
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      confirm_os_window_close = 0;
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "JetBrainsMono Nerd Font Propo 13";
    terminal = "\${pkgs.kitty}/bin/kitty";
    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Tela-circle-dracula";
      show-icons = true;
      terminal = "alacritty";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 󰕰  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        blue = mkLiteral "#cba6f7";
        border-col = mkLiteral "#cba6f7";
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        padding.top = 1;
        source = "~/.config/pics/nixos-logo.png";
        height = 22;
      };
      display = {
        separator = " -> ";
      };
      modules = [
        "break"
        {
          type = "custom";
          format = "{#31}┌───────────────  | OS Info ───────────────┐";
        }
        {
          type = "command";
          key = "   OS";
          keyColor = "red";
          text = "hostnamectl | grep 'Operating System' | cut -f2 -d ':'";
        }
        {
          type = "command";
          key = "   Kernel";
          keyColor = "red";
          text = "echo $(cut -f1 -d '-' <<< $(uname -r)) Vanilla"; # HARDCODED change 'Vanilla' to your kernel type
        }
        {
          type = "packages";
          key = "   Pkgs";
          keyColor = "red";
        }
        {
          type = "custom";
          format = "{#31}└───────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "{#32}┌──────────────  | User Info ──────────────┐";
        }
        {
          type = "command";
          key = "   Username";
          keyColor = "green";
          text = "whoami";
        }
        {
          type = "WM";
          key = "  󰖲 WM";
          keyColor = "green";
        }
        {
          type = "theme";
          key = "   Theme";
          keyColor = "green";
        }
        {
          type = "terminal";
          key = "   Term";
          keyColor = "green";
        }
        {
          type = "custom";
          format = "{#32}└───────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "{#34}┌─────────────── 󰋊 | HW Info ───────────────┐";
        }
        {
          type = "command";
          key = "   CPU";
          keyColor = "blue";
          text = "echo $(lscpu | grep 'Model name' | cut -f31 -d ' ') $(lscpu | grep 'Model name' | cut -f32 -d ' ') $(lscpu | grep 'Model name' | cut -f33 -d ' ')";
        }
        {
          type = "gpu";
          format = "{2}";
          key = "   GPU";
          keyColor = "blue";
        }
        {
          type = "gpu";
          format = "{3}";
          key = "  └  Drv";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = "   Memory";
          keyColor = "blue";
        }
        {
          type = "command";
          key = "  󱦟 OS Age ";
          keyColor = "34";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          type = "uptime";
          key = "  󱫐 Uptime ";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "{#34}└───────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = 15;
          symbol = "circle";
        }
        "break"
      ];
    };
  };
}
