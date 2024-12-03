{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      github.vscode-pull-request-github

      bbenoist.nix
      kamadorueda.alejandra
      jnoortheen.nix-ide
      jeff-hykin.better-nix-syntax
      arrterian.nix-env-selector
      mkhl.direnv

      ms-python.python
      ms-python.flake8
      ms-python.black-formatter
      matangover.mypy

      dbaeumer.vscode-eslint
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";

      "git.autofetch" = true;
      "git.enableSmartCommit" = true;

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
    };
  };
}
