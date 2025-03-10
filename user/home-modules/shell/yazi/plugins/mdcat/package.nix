{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "mdcat-yazi";
  version = "unstable-2024-11-21";

  src = fetchFromGitHub {
    owner = "GrzegorzKozub";
    repo = "mdcat.yazi";
    rev = "d3d5089d06fe4ed14504726722f89c977f9eb54a";
    sha256 = "sha256-F6rNLWJxMmTOOlna6lev4m1h559BWftfy6pNoTqVGKw=";
  };

  buildPhase = ''
    mkdir $out
    cp $src/* $out
    mv $out/init.lua $out/main.lua
  '';

  meta = with lib; {
    description = "Preview markdown files in yazi with mdcat.";
    homepage = "https://github.com/GrzegorzKozub/mdcat.yazi";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
