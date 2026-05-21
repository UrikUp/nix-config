{
  modulesPath,
  pkgs,
  inputs,
  ...
} @ args:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  networking.hostName = "vps";

  boot.loader.grub = {
    # disko handles devices automatically
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.firewall.enable = true;

  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;

      # safer for initial deployment
      # after confirming urik user works,
      # change to "no"
      PermitRootLogin = "prohibit-password";
    };
  };

  services.fail2ban.enable = true;

  users.users.urik = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
    ];

    openssh.authorizedKeys.keys =
      [
        # replace with your real SSH key
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZ5OGuQvxV2faWMHcfRgaPHQ1rmTi5w2/ju6pSWcoZj my vps key"
      ]
      ++ (args.extraPublicKeys or [ ]);
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    curl
    gitMinimal
    neovim
    tmux
    htop
    btop
    mosh
    vim
  ];
  networking.firewall.allowedUDPPortRanges = [
  {
    from = 60000;
    to = 61000;
  }
];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "urik" ];
  };
  system.stateVersion = "26.05";
}
