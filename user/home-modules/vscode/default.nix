{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.module.user.vscode;
in
{
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
      package = pkgs.vscode;
      mutableExtensionsDir = false;
      # Disable some annoying and not ''nix way'' stuff
      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        extensions = with pkgs.vscode-extensions; [
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

          # Rust workflow
          rust-lang.rust-analyzer
          fill-labs.dependi
          vadimcn.vscode-lldb

          # Python workflow
          ms-python.python
          ms-python.flake8
          ms-python.black-formatter
          matangover.mypy

          dbaeumer.vscode-eslint
          chrischinchilla.vscode-pandoc
        ];
        /*
          * ++ (with pkgs.vscode-marketplace; [
          *   rust-lang.rust-analyzer
          * ]);
        */
        # TODO: Add more extensions
        userSettings = {
          workbench.colorTheme = "Catppuccin Mocha";

          editor = {
            fontFamily = "'JetBrainsMono Nerd Font Propo'";
            fontLigatures = true;
            fontSize = 16;
            minimap.sectionHeaderFontSize = 16;
            suggestFontSize = 16;
          };

          terminal = {
            integrated = {
              fontSize = 16;
              fontFamily = "'JetBrainsMono Nerd Font Propo'";
              fontLigatures.enabled = true;
            };
          };

          git = {
            autofetch = true;
            enableSmartCommit = true;
            confirmSync = false;
          };

          nix = {
            enableLanguageServer = true;
            serverPath = "nixd";
          };
        };
      };
    };
    home.file.".vscode/argv.json".text = builtins.toJSON {
      enable-crash-reporter = false;
      password-store = "gnome-libsecret";
    };
  };
}
