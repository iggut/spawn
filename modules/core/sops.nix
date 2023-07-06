{inputs,  ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  #sops.age = { #todo
  #  sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  #  generateKey = true;
  #};
}
