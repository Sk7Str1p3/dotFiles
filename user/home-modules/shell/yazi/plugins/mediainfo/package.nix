{
  lib,
  stdenv,
  fetchFromGitHub,
  ffmpeg,
  mediainfo,
}:
stdenv.mkDerivation {
  pname = "mediainfo-yazi";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "boydaihungst";
    repo = "mediainfo.yazi";
    rev = "86b0f0ff91dd11cd3ee247e96e2285efd85f81d6";
    sha256 = "sha256-+UFoL4/05sIMr1m1DlDLR7YH3QhOw7Zw/p0sBJkpgns=";
  };

  buildInputs = [
    ffmpeg
    mediainfo
  ];

  installPhase = ''
    mkdir $out
    cp $src/main.lua $out/main.lua
  '';
  postFixup = ''
    substituteInPlace $out/main.lua \
      --replace 'Command("ffmpeg")' 'Command("${ffmpeg}/bin/ffmpeg")' \
      --replace 'cmd = "mediainfo"' 'cmd = "${mediainfo}/bin/mediainfo"'
  '';

  meta = with lib; {
    description = "Yazi plugin for previewing media files.";
    homepage = "https://github.com/boydaihungst/mediainfo.yazi";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
