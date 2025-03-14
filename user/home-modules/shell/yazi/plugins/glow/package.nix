{
  lib,
  stdenv,
  fetchFromGitHub,
  glow,
}:
stdenv.mkDerivation {
  pname = "glow-yazi";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "c76bf4fb612079480d305fe6fe570bddfe4f99d3";
    sha256 = "sha256-DPud1Mfagl2z490f5L69ZPnZmVCa0ROXtFeDbEegBBU=";
  };

  buildInputs = [
    glow
  ];

  installPhase = ''
    mkdir $out
    cp $src/main.lua $out/main.lua
  '';
  postFixup = ''
    substituteInPlace $out/main.lua \
      --replace "glow" "${glow}/bin/glow"
  '';

  meta = with lib; {
    description = "Plugin for Yazi to preview markdown files with glow.";
    homepage = "https://github.com/Reledia/glow.yazi";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
