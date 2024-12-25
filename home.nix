# link: https://nix-community.github.io/home-manager/options.xhtml
{
  inputs,
  config,
  pkgs,
  ...
}: {
  # # You may split your configuration into many files. If so, list them in imports.
  # # Also imports can be used for enabling programs added with flakes.
  imports = [
    ./hypr
    ./themes
    ./shell
    ./editors
    ./home
    ./web
    ./non-nix
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
    #firefox
    blender
    gtk3
    gtk4
    yazi
    gimp
    blender
    vesktop
    git-credential-manager
    figlet
    rofi-wayland
    rofi-power-menu
    wine-staging
    steam
    obs-studio
    zapret
    obsidian
    gcc
    gdb
    onefetch
    wofi

    inputs.ayugram.packages.${pkgs.system}.ayugram-desktop

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # You can enable systemd units per-user (actually nuh-uh you cant. very sad((()
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
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
      name = "JetBrainsMono Nerd Font Propo";
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
    terminal = "${pkgs.kitty}/bin/kitty";
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
}
