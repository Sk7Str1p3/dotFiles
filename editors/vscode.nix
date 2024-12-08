{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      github.vscode-pull-request-github
      chrischinchilla.vscode-pandoc

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

      "editor.fontFamily" = "'JetBrainsMono Nerd Font Propo'";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16;
      "editor.minimap.sectionHeaderFontSize" = 16;
      "editor.suggestFontSize" = 16;

      "terminal.integrated.fontSize" = 16;
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Propo'";
      "terminal.integrated.fontLigatures" = true;

      "git.autofetch" = true;
      "git.enableSmartCommit" = true;

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "git.confirmSync" = false;
    };
  };
}
