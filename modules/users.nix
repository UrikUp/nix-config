{ config, pkgs, ... }: {
  age.secrets.password.file = ../secrets/password.age;
  age.identityPaths = [
    "/home/urik/.ssh/id_ed25519"
  ];

  users.users.urik = {
    isNormalUser = true;
    description  = "";
    extraGroups  = [ "networkmanager" "wheel" "docker" "input" "keyd" ];
    shell        = pkgs.fish;
    hashedPasswordFile = config.age.secrets.password.path;
  };
}
