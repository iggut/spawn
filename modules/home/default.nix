{inputs, ...}:
# glue all configs together
{
  config = {
    home.stateVersion = "23.05";
    home.extraOutputsToInstall = ["doc" "devdoc"];
    manual = {
      html.enable = false;
      json.enable = false;
      manpages.enable = false;
    };
  };
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.nix-index-db.hmModules.nix-index
    inputs.anyrun.homeManagerModules.default

    ./packages.nix
    ./games.nix
    
    ./anyrun
    ./bottom
    ./discord
    ./firefox
    ./git
    ./gtk
    ./hyprland
    ./kitty
    ./mako
    ./media
    ./neovim
    ./pass
    ./rnnoise
    ./shell
    ./swaylock
    ./tools
    ./vscode
    ./zathura
  ];

  # Mullvad VPN
  services.mullvad-vpn.enable = lib.mkDefault true;
}
