{
  services.nginx = {
  enable = true;
  recommendedProxySettings = true;
  recommendedTlsSettings = true;
  recommendedGzipSettings = true;
  recommendedOptimisation = true;

  virtualHosts = {
    "urik.qzz.io" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8000";
        proxyWebsockets = true;
      };
    };
  };
};

security.acme = {
  acceptTerms = true;
  defaults.email = "975urikup@gmail.com";
};

networking.firewall.allowedTCPPorts = [ 80 443 ];

}
