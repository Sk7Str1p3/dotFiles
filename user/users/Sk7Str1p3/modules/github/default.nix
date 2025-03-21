{pkgs, ...}: {
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

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-s
      gh-markdown-preview
    ];
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };
  programs.gh-dash.enable = true;
}
