# {pkgs, ... }: {
#   programs.mango.enable = true;
  
#   services.noctalia-shell.enable = true;
#   nix.settings = {
#     extra-substituters = [ "https://noctalia.cachix.org" ];
#     extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
#   };
#   # for screenshots: grim - slurp
# }
{ pkgs, lib, ... }: {
  programs.mango.enable = true;

  services.noctalia-shell.enable = true;

  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  systemd.user.services.noctalia-shell = {
    wantedBy = lib.mkForce [ "mango-session.target" ];
    partOf = lib.mkForce [ "mango-session.target" ];
    after = lib.mkForce [ "mango-session.target" ];
  };
}
