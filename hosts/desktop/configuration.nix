{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/default.nix
  ];

  networking = {
    hostName = "nixos";
    wireless.enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };

  system.stateVersion = "26.05";
}
