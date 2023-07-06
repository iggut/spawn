{...}: {
  imports = [
    ./network.nix
    ./nix.nix
    #./openssh.nix #todo
    ./podman.nix
    ./security.nix
    ./sops.nix
    ./syncthing.nix
    ./system.nix
    ./users.nix
  ];
}
