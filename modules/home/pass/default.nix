{ pkgs, ...}:

{
  home.packages = with pkgs; [
    rbw
  ];
}
