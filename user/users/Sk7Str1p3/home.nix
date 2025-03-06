{
  headless,
  pkgs,
  isDarwin,
  ...
}: {
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
    };

    discord.enable = !headless;
    firefox.enable = !headless;

    hypr = {
      land.enable = !headless && !isDarwin;
      idle.enable = !headless && !isDarwin;
      paper.enable = !headless && !isDarwin;
      lock.enable = !headless && !isDarwin;
    };
  };
}
