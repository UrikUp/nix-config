# adminer.nix
{ config, pkgs, lib, ... }:

{
  packages.adminer = {
    enable = true;
    # enable.Nginx = true;
    # listen = "127.0.0.1:8080";
  };

  # # ── PostgreSQL ────────────────────────────────────────────────────────────
  # services.postgresql = {
  #   enable  = true;
  #   package = pkgs.postgresql_16;
  # };

  # # ── MariaDB (for Laravel projects) ───────────────────────────────────────
  # services.mysql = {
  #   enable  = true;
  #   package = pkgs.mariadb;
  # };

  # networking.firewall.allowedTCPPorts = [ 8080 ];
}
