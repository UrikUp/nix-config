{ modulesPath, pkgs, inputs, ... } @ args: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ../../modules/common
    ../../modules/server
  ];

  networking.hostName = "vps";
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.firewall.enable = true;
  networking.firewall.allowedUDPPortRanges = [
    { from = 60000; to = 61000; }
  ];

  users.users.urik = {
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys =
      [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZ5OGuQvxV2faWMHcfRgaPHQ1rmTi5w2/ju6pSWcoZj my vps key" ]
      ++ (args.extraPublicKeys or [ ]);
  };

  environment.systemPackages = with pkgs; [
    curl gitMinimal neovim tmux htop btop mosh vim
  ];

  system.stateVersion = "26.05";
}
