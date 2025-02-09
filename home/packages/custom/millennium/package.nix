{
  stdenv,
  lib,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "Millennium";
  version = "2.17.2";

  src = fetchFromGitHub {
    owner = "shdwmrt";
    name = "millennium";
    rev = "${version}";
    sha256 = lib.fakeSha256;
  };

  buildPhase = ''
    ls ./.
  '';

  meta = with lib; {
    maintainers = with maintainers; [Sk7Str1p3];
  };
}
