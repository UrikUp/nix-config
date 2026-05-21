{ inputs, pkgs, config, lib, ... }:
{
  imports = [
      ./cli.nix
      ./terminal.nix
      ./media.nix
      ./desktop.nix
      ./dev.nix
      # ./home/theming.nix
      # ./home/stylix.nix
      ./firefox.nix
      ./rclone.nix
      ./stylix.nix
  ];
  home.username      = "urik";
  home.homeDirectory = "/home/urik";
  home.stateVersion  = "26.05";
  programs.home-manager.enable = true;

  home = {
    packages = [
      pkgs.inter
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.kdePackages.qtstyleplugin-kvantum
    ];
    sessionVariables = {
      EDITOR        = "hx";
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE  = "20";
      # workaround to make text bigger, but not to use scaling
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1.25";   # was 1.2 → bigger
      # QT_SCALE_FACTOR = "0.9";
      QT_SCALE_FACTOR = "1";
      QT_FONT_DPI = "125";      # was 120 → bigger
      XFT_DPI = "125";          # was 120 → bigger
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "0";
      # 
      # QT_USE_PHYSICAL_DPI = "1";
    }; 
    sessionPath = [
      "$HOME/go/bin"        
    ];
  };
}
