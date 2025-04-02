{ isDarwin, ... }:
let
  username = "Sk7Str1p3";
in
{
  home.persistence = {
    "/persist/${username}" = {
      enable = !isDarwin;
      
      allowOther = true;

      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"

        ".cargo" # TODO: set up crane

        ".mozilla" # TODO: set up firefox with nix
        ".local/share/Trash"
        ".local/share/bottles"
      ];
      files = [
        ".local/share/fish/fish_history"
        ".local/share/nix/repl-history"
      ];
    };
  };
}
