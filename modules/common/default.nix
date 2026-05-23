{ ... }: {
  imports = [
    ./locale.nix
    ./nix-settings.nix
    ./users.nix
    ./docker.nix
  ];
}
