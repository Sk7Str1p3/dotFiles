{
  headless,
  pkgs,
  isDarwin,
  ...
}: {
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
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
    };

    discord.enable = !headless;
    firefox.enable = !headless;

    theme = {
      gtk.enable = !isDarwin && !headless;
    };

    hypr = {
      land.enable = !headless && !isDarwin;
      idle.enable = !headless && !isDarwin;
      paper.enable = !headless && !isDarwin;
      lock.enable = !headless && !isDarwin;
    };
  };
}
