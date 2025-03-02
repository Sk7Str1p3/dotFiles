{isDarwin, ...}: let
  username = "Sk7Str1p3";
in {
  home.persistence = {
    "/persist/home/${username}" = {
      enable = !isDarwin;
      allowOther = true;

      directories = [];
      files = [];
      #TODO
    };
  };
}
