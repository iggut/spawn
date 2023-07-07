{
  pkgs,
  inputs,
  ...
}: let
  nur-modules = import inputs.nur {
    nurpkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  };
in {
  home.packages = with pkgs; [
    nur-modules.repos.colinsane.pkgs.lemoa
    anki-bin
    bandwhich
    bc
    blueberry
    catimg
    cached-nix-shell
    chromium
    element-desktop
    fd
    ffmpeg
    foliate
    gimp
    glow
    grex
    hyperfine
    imagemagick
    jellyfin-media-player
    jq
    lm_sensors
    mullvad-vpn # VPN Client
    newsflash
    nwg-drawer
    nwg-panel
    nmap
    obsidian
    quodlibet-full
    rsync
    todo
    unzip
    vlc
    xh
    yt-dlp
    ######
    bottles # Wine manager
    cemu # Wii U Emulator
    spotify # Music streaming service
    godot_4 # Game engine for 2D and 3D games
    heroic # Epic Games Launcher for Linux
    input-remapper # Tool for remapping input device controls
    papermc # Minecraft server software
    protontricks # Tool for managing Winetricks for Proton prefixes
    scanmem # Cheat engine for Linux
    stremio # Streaming platform for movies and TV shows
    prusa-slicer # 3D printer slicer software for slicing 3D models into printable layers
    inav-configurator # The iNav flight control system configuration tool
    betaflight-configurator # The Betaflight flight control system configuration tool
    ######
    yubikey-manager
    yubikey-manager-qt
    yubioath-flutter
    yubico-pam
    yubikey-personalization
    age-plugin-yubikey
    ######
  ];
}
