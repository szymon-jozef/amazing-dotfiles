{ pgks, ... }:

{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };
}
