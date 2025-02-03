{
  stdenv,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages,
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
    sha256 = "sha256-mflwufC82jHGhKjBWzQHfNezd3+rk62XX1az8awjl2s=";
  };
  projectFile = "./SFP.sln";
  dotnet-runtime = dotnetCorePackages.runtime_8_0;

  runtimeDeps = [
    zlib
    stdenv.cc.cc
    icu
    openssl
  ];
  nugetDeps = ./nuDeps.json;
  executables = ["sfp-ui"];

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
