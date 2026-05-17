
{ config, pkgs, ... }: {
  # services.libinput.enable = true; # mouse support
  environment.systemPackages = with pkgs;
    [ (sddm-astronaut.override { embeddedTheme = "purple_leaves"; }) ];
    # [ (sddm-astronaut.override { embeddedTheme = "black_hole"; }) ];
  services.displayManager.sddm = {
    enable = true;
    wayland.compositor = "kwin";
    wayland.enable = true;
    package = pkgs.kdePackages.sddm; # qt6 sddm version
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [ sddm-astronaut bibata-cursors ];
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Classic"; # the cursor name here matters
        CursorSize = 20;
      };
    };
  };
}
