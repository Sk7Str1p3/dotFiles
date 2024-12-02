{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc

      bbenoist.nix
      kamadorueda.alejandra
      jnoortheen.nix-ide
      jeff-hykin.better-nix-syntax
      arrterian.nix-env-selector
      mkhl.direnv

      ms-python.python
      ms-python.debugpy
      ms-python.flake8
      ms-python.vscode-pylance
      ms-pyright.pyright
      ms-python.black-formatter
      matangover.mypy

      dbaeumer.vscode-eslint
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "git.autofetch" = "true";
    };
  };
}
