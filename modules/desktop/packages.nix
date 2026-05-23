{ pkgs, inputs, ... }: {
  nixpkgs.config.allowUnfree = true; 
  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; [
      xwayland-satellite
      go
      libgcc
      kdePackages.breeze
      libnotify
      ydotool
      gsettings-desktop-schemas
      glib
      adw-gtk3
      nodejs
      xrdb
      bibata-cursors
      adwaita-icon-theme
      librsvg
      shared-mime-info
      kdePackages.qtsvg
      wl-clipboard-rs
      inputs.agenix.packages.x86_64-linux.default
      zerotierone
      sshfs
      kdePackages.polkit-kde-agent-1
    ];
  };
}
