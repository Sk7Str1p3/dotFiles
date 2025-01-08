{
  lib,
  config,
  ...
}: let
  inherit
    (config.lib.stylix.colors.withHashtag)
    base00
    base01
    base02
    base03
    base04
    base05
    base06
    base07
    base08
    base09
    base0A
    base0B
    base0C
    base0D
    base0E
    base0F
    ;
in {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "[╭─](bold fg:${base03})"
        "[](fg:${base03})"
        "[ ](bg:${base03} fg:${base00})"
        "[](fg:${base03} bg:${base0A})"
        "$directory"
        "[](fg:${base0A} bg:${base04})"
        "$git_branch"
        "$git_commit"
        "$git_status"
        "$git_metrics"
        "[](fg:${base04} bg:${base01})"
        "$nix_shell"
        "$c"
        "$custom"
        "$java"
        "$python"
        "[](bg:blue fg:teal)"
        "$status"
        "[](fg:blue bg:mauve)"
        "$time"
        "[](bg:base fg:mauve)"
        "\n[╰─](bold fg:${base03})"
        "$character"
      ];
      directory = {
        format = "[ $path ]($style)[$read_only]($read_only_style)";
        style = "bg:${base0A} fg:${base04}";
        read_only = "󰉐 ";
        read_only_style = "bg:peach fg:surface0";
        home_symbol = "󱂵 ";
      };
      git_branch = {
        format = "[ $symbol$branch(:$remote_branch)]($style)";
        symbol = "󰊢 ";
        style = "bg:${base04} fg:${base0A}";
      };
      git_status = {
        format = "[ $all_status ]($style)";
        style = "bg:${base04} fg:${base0A}";
      };
      c = {
        symbol = "  ";
        style = "bg:${base01} fg:surface0";
        format = "[$symbol-> $name $version]($style)";
      };
      custom.cpp = {
        detect_extensions = [
          "cpp"
          "hpp"
          "cc"
        ];
        symbol = "  ";
        format = "[$symbol-> $output]($style)";
        command = "echo v$(clang++ --version | grep version | cut -f3 -d ' ')";
        style = "bg:${base01} fg:surface0";
        disabled = false;
      };
      python = {
        symbol = "  ";
        style = "bg:teal fg:surface0";
        format = "[$symbol$pyenv_prefix-> $version (\($virtualenv\) )]($style)";
      };
      nix_shell = {
        symbol = "  ";
        pure_msg = "[Pure](bg:${base01} fg:${base08})";
        impure_msg = "[Impure](bg:${base01} fg:${base0A})";
        unknown_msg = "[???](bg:${base01} fg:${base09})";
        style = "bg:teal fg:surface0";
        format = "[$symbol-> $name ($state)]($style)";
      };
      status = {
        disabled = false;
        symbol = "  ";
        success_symbol = "  ";
        not_executable_symbol = "  ";
        not_found_symbol = "  ";
        sigint_symbol = " 󱤷 ";
        signal_symbol = " 󱐋 ";
        map_symbol = true;
        style = "fg:crust bg:blue";
        format = "[$symbol $status ]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:mauve fg:surface0";
        format = "[ 󱑍 $time ]($style)";
      };
    };
  };
}
