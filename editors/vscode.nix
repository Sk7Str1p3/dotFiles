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

      ms-python.python
      ms-python.debugpy
      ms-python.flake8
      ms-python.vscode-pylance
      ms-pyright.pyright
      ms-python.black-formatter
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
    };
  };
}
