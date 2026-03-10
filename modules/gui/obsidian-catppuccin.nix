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
    hash = "sha256-IGkP0z8gJj1dbNclpMebZXZvaRby1F8zGNEDPtitfqo=";
  };

  installPhase = ''
    mkdir -p $out
    cp theme.css manifest.json $out/
  '';
}
