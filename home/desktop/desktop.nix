{ pkgs, inputs, ... }: 
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  home.packages = with pkgs; [
    zotero
    obsidian
    libreoffice-qt
    telegram-desktop
    # vesktop
    legcord
    seahorse
    proton-vpn
    blender
    onlyoffice-desktopeditors
    # kdePackages.dolphin
    # nautilus
    thunar
    taskwarrior3
    freelens-bin


    # games
    hydralauncher
    cemu
    gamescope
    # gamemode # defined inside modules
    qbittorrent
    pcsx2
    appimage-run
    inputs.freesmlauncher.packages.${pkgs.system}.freesmlauncher
    mangohud
  ];
  
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };
  programs.helium = {
    enable = true;
    flags = [
      "--force-device-scale-factor=1.30"
      "--ozone-platform-hint=auto"
    ];
  };

  programs.lutris = {
    enable = true;

    defaultWinePackage = pkgs.proton-ge-bin;
    protonPackages = [ pkgs.proton-ge-bin ]; # config.programs.steam.extraCompatPackages;
  };


  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      songStats
      autoVolume
      beautifulLyrics
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html"              = "firefox.desktop";
      "x-scheme-handler/http"  = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "application/pdf"        = "firefox.desktop";
    };
  };
  services.vicinae = {
    package = pkgs.vicinae;
    enable = true;
    systemd = {
      enable = true;
      autoStart = true; # default: false
      environment = {
        USE_LAYER_SHELL = 1;
      };
  };

  settings = {
    close_on_focus_loss = true;
    consider_preedit = true;
    pop_to_root_on_close = true;
    favicon_service = "twenty";
    search_files_in_root = true;
  };
  extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
     bluetooth
     nix
     # power-profile
    # Extension names can be found in the link below, it's just the folder names
    ];
  };

  services.syncthing = {
    enable = true;
  };
  virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;
users.users.urik.extraGroups = [ "libvirtd" ];
}
