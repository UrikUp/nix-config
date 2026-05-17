{
  services.resolved = {
    enable = true;

    settings = {
      Resolve = {
        DNSSEC = "allow-downgrade";
        Domains = [ "~." ];
        FallbackDNS = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
    };
  };

  networking.nameservers = [ "127.0.0.53" ];

  networking.firewall.enable = true;


  # ⚠ Отключай IPv6 ТОЛЬКО если уверен, что провайдер его не даёт
  # networking.enableIPv6 = false;


  networking.networkmanager = {
    enable = true;
  };
  services.timesyncd.enable = true;
}

