{ lib, pkgs, ... }:
let
  theme = {
    cursor = {
      name    = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size    = 20;
    };
    icons = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk = {
      name    = "catppuccin-mocha-mauve-standard+default";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "mocha";
      };
    };
  };
in
{
  home.packages = with pkgs; [
    catppuccin-kvantum
    gnome-themes-extra
  ];
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name    = "kvantum";
      package = pkgs.kdePackages.qtstyleplugin-kvantum;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name    = lib.mkForce theme.icons.name;
      package = lib.mkForce theme.icons.package;
    };
    cursorTheme = {
      inherit (theme.cursor) name package size;
    };
    theme = {
      inherit (theme.gtk) name package;
    };
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
      inherit (theme.cursor) name package size;
    };
    sessionVariables = {
      XCURSOR_THEME    = theme.cursor.name;
      XCURSOR_SIZE     = toString theme.cursor.size;
      HYPRCURSOR_THEME = theme.cursor.name;
    };
  };

  dconf.settings."org/gnome/desktop/interface" = {
    cursor-theme = theme.cursor.name;
    cursor-size  = theme.cursor.size;
    icon-theme   = theme.icons.name;
    gtk-theme    = theme.gtk.name;
  };
  
}
