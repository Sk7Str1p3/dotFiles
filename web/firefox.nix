let
  mkExtension = id: install_url: {
    ${id} = {
      inherit install_url;
      installation_mode = "force_installed";
    };
  };
in {
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-GB"
      "ru"
    ];
    profiles.Sk7Str1p3.extensions = [
      (mkExtension "cliget@zaidabdulla.com" "https://addons.mozilla.org/firefox/downloads/latest/cliget/latest.xpi")
    ];
    #policies = ;
  };
}
