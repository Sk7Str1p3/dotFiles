{
  stdenv,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages,
  vistafonts,
  zlib,
  icu,
  openssl,
  lib,
}:
buildDotnetModule rec {
  pname = "SFP";
  version = "0.0.60-beta1";

  src = fetchFromGitHub {
    owner = "PhantomGamers";
    repo = "SFP";
    rev = "${version}";
    sha256 = lib.fakeSha256;
  };
  projectFile = "SFP.sln";
  dotnet-sdk = dotnetCorePackages.runtime_8_0;

  runtimeDeps = [
    zlib
    stdenv.cc.cc
    icu
    openssl
  ];
  executables = ["SFP-UI"];

  meta = with lib; {
    description = ''
      SFP (Formerly SteamFriendsPatcher) - utility allows you
      to apply skins and scripts to the new Steam client.
    '';
    maintainers = with maintainers; [
      Sk7Str1p3
    ];
    platforms = [
      "x86_64-linux"
    ];
    license = licenses.mit;
    homepage = "https://github.com/PhantomGamers/SFP";
  };
}
