{ pkgs, ... }: {
  imports = [
    ../common/default.nix
    (import ../common/dotfiles.nix { liveEditable = true; })
  ];

  home.username      = "urik";
  home.homeDirectory = "/home/urik";
  home.stateVersion  = "26.05";
  programs.home-manager.enable = true;

}
