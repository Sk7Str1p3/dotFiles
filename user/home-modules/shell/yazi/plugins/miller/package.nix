{
  lib,
  stdenv,
  fetchFromGitHub,
  miller,
}:
stdenv.mkDerivation {
  pname = "miller-yazi";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "Reledia";
    repo = "miller.yazi";
    rev = "40e02654725a9902b689114537626207cbf23436";
    sha256 = "sha256-GXZZ/vI52rSw573hoMmspnuzFoBXDLcA0fqjF76CdnY=";
  };

  buildInputs = [
    miller
  ];

  installPhase = ''
    mkdir $out
    cp $src/init.lua $out/main.lua
  '';
  postFixup = ''
    substituteInPlace $out/main.lua \
      --replace "mlr" "${miller}/bin/mlr"
  '';

  meta = with lib; {
    description = "Miller now in yazi.";
    homepage = "https://github.com/Reledia/miller.yazi";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
