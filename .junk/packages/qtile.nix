{config, pkgs, ...}: {

specialisation.qtile.configuration = {
  services.xserver = {
    enable = true;
    # xcursor = {
    #   theme = "Bibata-Modern-Classic";
    #   size = 20;
    # };
    dpi = 120;
    windowManager.qtile = {
      enable = true;
      extraPackages = p: with p; [ qtile-extras ];
    };
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        accelSpeed = "0.3";
        tapping = true;
        scrollMethod = "twofinger";
        clickMethod = "clickfinger";
        middleEmulation = false;
      };
    };
  };
  services.picom = {
      enable = true;
      settings = {
        backend = "glx";
        vsync = true;
        use-damage = true;
        unredir-if-possible = true;
        shadow = false;
      };
    };

  environment.systemPackages = with pkgs; [
    # flameshot
    libinput-gestures
    nitrogen
    rofi
    haskellPackages.greenclip
    dunst
    pamixer
    brightnessctl
    playerctl
    python3Packages.psutil
    python3Packages.mypy
    python3Packages.iwlib
    # xclip
    # arandr
    # polkit-gnome
    xsettingsd
    xev
    # i3lock
  ];
  environment.sessionVariables = {
    QT_FONT_DPI                 = "120";
    QT_STYLE_OVERRIDE           = "kvantum";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XCURSOR_THEME               = "Bibata-Modern-Classic";
    XCURSOR_SIZE                = "20";
  };

 };
}
