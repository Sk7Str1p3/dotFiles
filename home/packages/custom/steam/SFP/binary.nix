{
  stdenv,
  vistafonts,
  zlib,
  icu,
  openssl,
  lib,
}:
stdenv.mkDerivation {
  pname = "SFP-bin";
  version = "0.0.60-beta1";

  src = fetchTarball {
    url = "https://github.com/PhantomGamers/SFP/releases/latest/download/SFP_UI-linux-x64-SelfContained.tar.gz";
    sha256 = "sha256:0nsg9g4azk23fpy69mivjm5cx422mdysfxxjq56h5wnnx6snp450";
  };
  buildInputs = [
    vistafonts
  ];

  installPhase = ''
    mkdir $out
    mkdir $out/bin
    cp ./SFP_UI $out/bin/SFP_UI-bin
  '';
  postFixup = ''
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/SFP_UI
    patchelf --set-rpath "${
      lib.makeLibraryPath [
        zlib
        stdenv.cc.cc
        icu
        openssl
      ]
    }" $out/bin/SFP_UI
  '';
  dontStrip = true;

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
