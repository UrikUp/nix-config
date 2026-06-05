{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common
    ../../modules/desktop
  ];

  networking = {
    hostName = "desktop";
    wireless.enable = true;
  };
  networking.firewall.allowedTCPPorts = [ 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  system.stateVersion = "26.05";
}
