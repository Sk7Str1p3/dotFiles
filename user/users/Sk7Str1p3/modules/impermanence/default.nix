{ isDarwin, ... }:
let
  username = "Sk7Str1p3";
in
{
  home.persistence = {
    "/nix/persist/user/${username}" = {
      enable = !isDarwin;

      allowOther = true;

      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"

        ".cargo"

        ".mozilla" # TODO: set up firefox with nix
        ".local/share/Trash"
        ".local/share/bottles"
        ".local/share/keyrings"
        ".local/share/direnv"
      ];
      files = [
        ".local/share/fish/fish_history"
        ".local/share/nix/repl-history"
        ".config/onefetch/config.toml"
      ];
    };
  };
}
