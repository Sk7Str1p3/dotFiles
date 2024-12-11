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
      #async-prompt
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
      os-rebuild = "sudo echo ; sudo nixos-rebuild switch &| nom";
      os-update = "sudo echo ; sudo nixos-rebuild switch --upgrade-all &| nom";
      os-cleanup = "sudo nix-collect-garbage -d";
      os-edit = "code /etc/nixos";

      hm-update = "home-manager switch --impure -b bak &| nom";
      hm-edit = "code ~/.config/home-manager";

      corr = "fuck";
    };
  };
}
