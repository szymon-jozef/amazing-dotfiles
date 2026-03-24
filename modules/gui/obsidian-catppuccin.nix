{
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "obsidian-catppuccin";
  version = "main";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "obsidian";
    rev = "main";
    hash = "sha256-uB0a2nSZkHHf65xBYXyNh50vaAiqdEpKQVf3eXnCVlE=";
  };

  installPhase = ''
    mkdir -p $out
    cp theme.css manifest.json $out/
  '';
}
