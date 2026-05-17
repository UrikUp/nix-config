{ pkgs, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
      intel-media-driver
      intel-compute-runtime
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  hardware.enableAllFirmware = true;

  # WiFi power management — disable to prevent disconnects (rtw88 driver)
  boot.extraModprobeConfig = ''
    options rtw88_8821ce rtw_power_mgnt=0
  '';

  # thermald sets thermal ceiling, auto-cpufreq optimizes within it
  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    # Stylix already handles: Noto Sans, Noto Serif, JetBrainsMono, Noto Emoji
    packages = with pkgs; [
      noto-fonts-cjk-sans
      liberation_ttf
      dejavu_fonts
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      useEmbeddedBitmaps = true; # Firefox fix
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

  # services.libinput.enable = true; # mouse support
  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override { embeddedTheme = "purple_leaves"; })
    # (sddm-astronaut.override { embeddedTheme = "black_hole"; })
  ];
  services.displayManager.sddm = {
    enable = true;
    wayland.compositor = "kwin";
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [ sddm-astronaut bibata-cursors ];
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Classic";
        CursorSize = 20;
      };
    };
  };
}
