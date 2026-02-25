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
    hash = "sha256-sN5k263geOtJ1mOCQGM8UdmA/71OhBI5NRwGxJwd80E=";
  };

  installPhase = ''
    mkdir -p $out
    cp theme.css manifest.json $out/
  '';
}
