{ pkgs, lib, ... }: {
  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNSSEC = "allow-downgrade";
        Domains = [ "~." ];
        FallbackDNS = [ "1.1.1.1" "1.0.0.1" ];
      };
    };
  };
  networking.nameservers = [ "127.0.0.53" ];

  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  networking.firewall.enable = true;
  # ⚠ Отключай IPv6 ТОЛЬКО если уверен, что провайдер его не даёт
  # networking.enableIPv6 = false;

  services.timesyncd.enable = true;

  # ── Google Drive (rclone) ─────────────────────────────────────────────────
  environment.systemPackages = [ pkgs.rclone ];
  systemd.mounts = lib.singleton {
    where = "/mnt/gdrive";
    what = "Gdrive:";
    type = "rclone";
    options = "_netdev,args2env,vfs-cache-mode=minimal,config=/etc/rclone.conf,uid=1000,gid=1000,umask=002";
  };
  systemd.automounts = lib.singleton {
    where = "/mnt/gdrive";
    wantedBy = [ "multi-user.target" ];
  };
}
