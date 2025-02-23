{
  buildFirefoxXpiAddon,
  lib,
}:
buildFirefoxXpiAddon rec {
  pname = "catppuccin-firefox";
  version = "2.0";
  addonId = "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}";
  url = "https://addons.mozilla.org/firefox/downloads/file/3990325/catppuccin_mocha_mauve_git-${version}.xpi";
  sha256 = "sha256-pSlzVe7XbTbrC76iAinYrr7qIl69OpH3Wk00MoAIe74=";
  meta = with lib; {
    homepage = "https://github.com/catppuccin/firefox";
    description = "Soothing pastel theme for firefox!";
    maintainers = with maintainers; [
      Sk7Str1p3
    ];
    license = licenses.mit;
    platforms = platforms.all;
  };
}
