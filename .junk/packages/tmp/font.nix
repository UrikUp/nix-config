{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    # Only include fonts here that Stylix isn't already handling.
    # Stylix automatically installs Noto Sans, Noto Serif, JetBrainsMono, and Noto Emoji.
    packages = with pkgs; [
      noto-fonts-cjk-sans
      liberation_ttf
      dejavu_fonts
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      useEmbeddedBitmaps = true; # Retained for your Firefox fix

      hinting = {
        enable = true;
        autohint = false;
        style = "slight";
      };

      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };
  };
}
