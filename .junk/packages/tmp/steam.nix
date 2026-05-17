{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";
      extraEnv = {
        XCURSOR_THEME                 = "breeze_cursors";
        XCURSOR_SIZE                  = "24";
        STEAM_FORCE_DESKTOPUI_SCALING = "1";
      };
    };
  };
}
