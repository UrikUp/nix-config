{ pkgs, ... }: {
  home.packages = with pkgs; [
    acpi
    ffmpeg
    pavucontrol
  ];

  programs.mpv = {
    enable = true;
    # catppuccin.enable = true;
    config = {
      profile = "gpu-hq";
      vo = "gpu";
      hwdec = "auto-safe";
      sub-auto = "fuzzy";
      sub-font-size = 40;
    };
    bindings = {
      "l" = "seek 5";
      "h" = "seek -5";
      "j" = "seek -60";
      "k" = "seek 60";   # vim-style seeking
    };
  };
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-pipewire-audio-capture
      wlrobs   # wayland screen capture
      advanced-scene-switcher
      ];
    };
}
