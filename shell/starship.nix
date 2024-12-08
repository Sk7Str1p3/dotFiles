{lib, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "[╭─](bold fg:surface0)"
        "[](bg:base fg:surface0)"
        "[ ](bg:surface0 fg:mauve)"
        "[](fg:surface0 bg:peach)"
        "$directory"
        "[](fg:peach bg:green)"
        "$git_branch"
        "$git_commit"
        "$git_status"
        "$git_metrics"
        "[](fg:green bg:teal)"
        "$c"
        "$custom"
        "$java"
        "$python"
        "$nix_shell"
        "[](bg:blue fg:teal)"
        "$status"
        "[](fg:blue bg:mauve)"
        "$time"
        "[](bg:base fg:mauve)"
        "\n[╰─](bold fg:surface0)"
        "$character"
      ];
      directory = {
        format = "[ $path ]($style)[$read_only]($read_only_style)";
        style = "bg:peach fg:surface0";
        read_only = "󰉐 ";
        read_only_style = "bg:peach fg:surface0";
        home_symbol = "󱂵 ";
      };
      git_branch = {
        format = "[ $symbol$branch(:$remote_branch)]($style)";
        symbol = "  ";
        style = "bg:green fg:surface0";
      };
      git_status = {
        format = "[$all_status ]($style)";
        style = "bg:green fg:surface0";
      };
      c = {
        symbol = " ";
        style = "bg:teal fg:surface0";
        format = "[$symbol $name $version]($style)";
      };
      custom.cpp = {
        detect_extensions = [
          "cpp"
          "hpp"
          "cc"
        ];
        symbol = " ";
        format = "[$symbol $output]($style)";
        command = "echo v$(clang++ --version | grep version | cut -f3 -d ' ')";
        style = "bg:teal fg:surface0";
        disabled = false;
      };
      python = {
        symbol = " ";
        style = "bg:teal fg:surface0";
        format = "[$symbol$pyenv_prefix $version (\($virtualenv\) )]($style)";
      };
      nix_shell = {
        symbol = " ";
        pure_msg = "[Pure](bg:teal fg:surface0)";
        impure_msg = "[Impure](bg:teal fg:red)";
        unknown_msg = "[???](bg:teal fg:peach)";
        style = "bg:teal fg:surface0";
        format = "[$symbol $name ($state)]($style)";
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
