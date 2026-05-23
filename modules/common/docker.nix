{ ... }: {
  virtualisation.docker.enable = true;
  systemd.services.docker = {
    after  = [ "network.target" ];
    wants  = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
  };
}
