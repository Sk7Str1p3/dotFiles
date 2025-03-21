{
  headless,
  pkgs,
  isDarwin,
  ...
}: {
  home.packages = with pkgs; [
    # ideally should be empty
    # because home-manager provides modules for almost all apps
    gimp
    blender
    lunarvim
    neovide
    vimPlugins.LazyVim
    git-credential-manager
    obsidian
    onefetch

    adwsteamgtk
    bottles
    wineWow64Packages.stableFull
    winetricks
    prismlauncher

    nautilus
    gnome-disk-utility
    gnome-calculator
    gnome-calendar
    gnome-software
    gnome-logs
    gnome-connections
    baobab
    loupe
    totem

    hyprshot
    hyprpicker

    transmission_3-gtk
    qbittorrent-enhanced
    samba
    ayugram-desktop
    nekoray
  ];

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
        name = "Sk7Str1p3";
      };
    };
  };
  nixpkgs.overlays = [];
  module.user = {
    kitty.enable = !headless;
    vscode.enable = !headless;

    shell = {
      fish.enable = true;
      starship.enable = true;
      yazi.enable = true;
      direnv.enable = true;
      fastfetch.enable = true;
      eza.enable = true;
      nh.enable = true;
      nix-shell.enable = true;
      rg.enable = true;
    };

    discord.enable = !headless;
    firefox.enable = !headless;

    rofi.enable = true;
    ags.enable = true;

    theme = {
      cursor.enable = !isDarwin && !headless;
      font.enable = true;
      gtk.enable = !isDarwin && !headless;
    };

    hypr = {
      land.enable = !headless && !isDarwin;
      idle.enable = !headless && !isDarwin;
      paper.enable = !headless && !isDarwin;
      lock.enable = !headless && !isDarwin;
      cursor.enable = !headless && !isDarwin;
      sunset.enable = !headless && !isDarwin;
    };
  };
}
