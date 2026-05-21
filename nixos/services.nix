{ pkgs, ... }: {
  services.kanata = {
    enable = true;
    keyboards.default = {
      extraDefCfg = "rapid-event-delay 0";
      config = ''
        (defsrc
          lmet lalt caps
        )
        (deflayer default
          lalt lmet (tap-hold-press 100 100 caps lmet)
        )
      '';
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "postgres" ];
    ensureUsers = [{
      name = "postgres";
      ensureDBOwnership = true;
    }];
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host  all all 127.0.0.1/32 trust
    '';
  };

  services.gnome.gnome-keyring.enable = true;
  services.openssh.enable= true;
  services.dbus.packages = [ pkgs.gsettings-desktop-schemas ];

  services.zerotierone.enable = true;
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };

  virtualisation.docker.enable = true;
  systemd.services.docker = {
    after  = [ "network.target" ];
    wants  = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
  };

  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660"
  '';
}
