{ config, pkgs, ... }: {
  age.secrets.password.file = ../../secrets/password.age;
  age.identityPaths = [ "/home/urik/.ssh/id_ed25519" ];

  users.users.urik = {
    extraGroups = [ "networkmanager" "wheel" "docker" "input" "keyd" ];
    hashedPasswordFile = config.age.secrets.password.path;
    shell = pkgs.fish;
  };
}
