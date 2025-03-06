{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.module.user.vscode;
in {
  # Declare Options
  options = {
    module.user.vscode = {
      enable = mkEnableOption "Visual Studio Code";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.stable.vscode;
      # Disable some annoying and not ''nix way'' stuff
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      mutableExtensionsDir = false;
      extensions = with pkgs.stable.vscode-extensions;
        [
          # VSC generic extensions
          catppuccin.catppuccin-vsc
          leonardssh.vscord
          github.copilot
          github.copilot-chat

          # Better Git integration
          mhutchie.git-graph
          github.vscode-pull-request-github
          eamodio.gitlens

          # Nix-specific extensions for better workflow
          bbenoist.nix
          kamadorueda.alejandra
          jnoortheen.nix-ide
          jeff-hykin.better-nix-syntax
          arrterian.nix-env-selector
          mkhl.direnv

          # C workflow
          ms-vscode.cmake-tools

          # Rust workflow # TODO: wait for fix on rust-analyzer; for now replaced with custom extension
          # rust-lang.rust-analyzer
          fill-labs.dependi
          vadimcn.vscode-lldb

          # Python workflow
          ms-python.python
          ms-python.flake8
          ms-python.black-formatter
          matangover.mypy

          dbaeumer.vscode-eslint
          chrischinchilla.vscode-pandoc
        ]
        ++ (with pkgs.vscode-marketplace-release; [
          rust-lang.rust-analyzer
        ]);
      # TODO: Add more extensions
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
        "git.confirmSync" = false;

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
      };
    };
    home.file.".vscode/argv.json".text = builtins.toJSON {
      enable-crash-reporter = false;
      password-store = "gnome-libsecret";
    };
  };
}
