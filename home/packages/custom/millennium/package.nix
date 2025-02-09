{
  multiStdenv,
  lib,
  fetchFromGitHub,
  gnumake,
  cmake,
  asio,
  nlohmann_json,
  crow,
  fmt,
  websocketpp,
  curl,
}:
multiStdenv.mkDerivation {
  pname = "millennium";
  version = "2.17.2";

  src = fetchFromGitHub {
    owner = "shdwmtr";
    repo = "millennium";
    rev = "better-unix-fhs";
    sha256 = "sha256-WBMgkXWRl9/iAdPApcqDRGGAtb8VxL4fSc8ZKJldnHI=";
  };
  buildInputs = [
    gnumake
    cmake
    curl
    asio
    #boxer
    crow
    fmt
    nlohmann_json
    websocketpp
  ];

  buildPhase = ''
    make
  '';

  meta = with lib; {
    maintainers = with maintainers; [Sk7Str1p3];
  };
}
