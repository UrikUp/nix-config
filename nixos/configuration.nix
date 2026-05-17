{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./locale.nix
    ./users.nix
    ./services.nix
    ./packages.nix
    ./programs.nix
    ./hardware.nix
    ./network.nix
    ./system.nix
    ./stylix.nix
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
