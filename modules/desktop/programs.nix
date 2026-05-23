{ pkgs, inputs, ... }: {

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 5";
    flake = "/home/urik/nix";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc.lib ];

  programs.fish.enable = true;
  programs.mtr.enable  = true;
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  programs.gamemode.enable = true;

  programs.dms-shell = {
    enable = true;
    # quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";
    };
  };

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };

  programs.kdeconnect.enable = true;
}
