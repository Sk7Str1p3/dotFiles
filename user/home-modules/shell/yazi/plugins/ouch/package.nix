{
  lib,
  stdenv,
  fetchFromGitHub,
  ouch,
}:
stdenv.mkDerivation {
  pname = "mediainfo-yazi";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "ce6fb75431b9d0d88efc6ae92e8a8ebb9bc1864a";
    sha256 = "sha256-oUEUGgeVbljQICB43v9DeEM3XWMAKt3Ll11IcLCS/PA=";
  };

  buildInputs = [
    ouch
  ];

  installPhase = ''
    mkdir $out
    cp $src/main.lua $out/main.lua
  '';
  postFixup = ''
    substituteInPlace $out/main.lua \
      --replace 'Command("ouch")' 'Command("${ouch}/bin/ouch")' \
  '';

  meta = with lib; {
    description = "An ouch plugin for Yazi, supporting preview and compression.";
    homepage = "https://github.com/ndtoan96/ouch.yazi";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
