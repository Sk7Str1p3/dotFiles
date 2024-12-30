{pkgs, ...}: {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "Done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "1.19.3";
          hash = "sha256-DMIRKRAVOn7YEnuAtz4hIxrU93ULxNoQhW6juxCoh4o=";
        };
      }
      /*
        {
        name = "Async";
        src = pkgs.fetchFromGitHub {
          owner = "acomagu";
          repo = "fish-async-prompt";
          rev = "v1.2.0";
          hash = "sha256-B7Ze0a5Zp+5JVsQUOv97mKHh5wiv3ejsDhJMrK7YOx4=";
        };
      }
      */
      #puffer
    ];
    interactiveShellInit = ''
      set fish_greeting
      any-nix-shell fish --info-right | source
      fastfetch
    '';
    functions = {
      yy = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        	builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };
    shellAliases = {
      os-rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#GodlikeNix &| nom";
      os-update = "nix flake update --flake /etc/nixos ; sudo nixos-rebuild switch --flake /etc/nixos#GodlikeNix &| nom";
      os-cleanup = "sudo nix-collect-garbage --delete-older-than 3d";
      os-edit = "code /etc/nixos";

      hm-rebuild = "home-manager switch --impure -b bak &| nom";
      hm-update = "nix flake update --flake ~/.config/home-manager ; home-manager switch --impure -b bak &| nom";
      hm-edit = "code ~/.config/home-manager";

      ls = "eza";
      corr = "fuck";
    };
  };
}
