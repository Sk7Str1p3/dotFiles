{
  stdenv,
  fetchFromGithub,
  dotnet-runtime_8,
  vistafonts,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "SFP";
  version = "0.0.60-beta1";
  src = fetchFromGithub {
    owner = "PhantomGamers";
    repo = "SFP";
    rev = "${version}";
    sha256 = "sha256-pSlzVe7XbTbrC76iAinYrr7qIl69OpH3Wk00MoAIe74=";
  };
  buildInputs = [
    dotnet-runtime_8
    vistafonts
  ];
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
