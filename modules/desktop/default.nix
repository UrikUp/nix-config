{ ... }: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ./network.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./stylix.nix
    ./system.nix
    ./users.nix
  ];

  security.polkit.enable = true;
}
