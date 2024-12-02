{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
            set fish_greeting
            any-nix-shell fish --info-right | source
            fastfetch

            function yy
      	set tmp (mktemp -t "yazi-cwd.XXXXXX")
      	yazi $argv --cwd-file="$tmp"
      	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      		builtin cd -- "$cwd"
      	end
      	rm -f -- "$tmp"
            end
    '';
    shellAliases = {
      rebuild = "echo 'Password:' && sudo nixos-rebuild switch &| nom";
      update = "echo 'Password:' && sudo nixos-rebuild switch --upgrade-all &| nom";
      hm-update = "home-manager switch --impure -b bak";
    };
  };
}
