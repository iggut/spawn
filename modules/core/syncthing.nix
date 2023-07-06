{...}: {
  services.syncthing = {
    enable = true;
    user = "iggut";
    systemService = false;
  };
}
