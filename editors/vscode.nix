{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      # VSC generic extensions
      catppuccin.catppuccin-vsc

      # Better Git integration
      mhutchie.git-graph
      github.vscode-pull-request-github
      eamodio.gitlens

      # Nix-specific extensions for better workflow
      bbenoist.nix
      kamadorueda.alejandra
      jnoortheen.nix-ide
      jeff-hykin.better-nix-syntax
      # arrterian.nix-env-selector
      mkhl.direnv

      # Rust workflow
      rust-lang.rust-analyzer
      fill-labs.dependi

      # Python workflow
      ms-python.python
      ms-python.flake8
      ms-python.black-formatter
      matangover.mypy

      dbaeumer.vscode-eslint
      chrischinchilla.vscode-pandoc
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
