{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  wayland = ../modules/wayland;
  hw = inputs.nixos-hardware.nixosModules;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [core bootloader wayland];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.iggut = ../modules/home;
  };
in {


  # laptop
  gs66 = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "gs66";}
        ./gs66/hardware-configuration.nix
        ./gs66/hardware.nix
        ./gs66/nvidia.nix
        hw.common-cpu-intel
        hw.common-gpu-nvidia
        hw.common-pc-laptop
        hmModule
        {
          programs.hyprland.nvidiaPatches=true;
          programs.hyprland.xwayland.enable=true;
        }
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # main desktop
  # very much a WIP
  gaminix = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "gaminix";}
        ./gaminix/hardware-configuration.nix
        ./gaminix/hardware.nix
        bootloader
        hw.common-cpu-amd
        hw.common-gpu-amd
        # hw.common-pc-ssd
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
  
  # gleeok naydra and valoo are future projects :)
}
