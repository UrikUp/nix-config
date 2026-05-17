{ pkgs, lib, ... }:
let
  mountPoint = "/mnt/gdrive";
  remoteName = "Gdrive";
in
{
  environment.systemPackages = [ pkgs.rclone ];

  systemd.mounts = lib.singleton {
    where = mountPoint;
    what = "${remoteName}:";
    type = "rclone";
    options = "_netdev,args2env,vfs-cache-mode=minimal,config=/etc/rclone.conf,uid=1000,gid=1000,umask=002";
  };

  systemd.automounts = lib.singleton {
    where = mountPoint;
    wantedBy = [ "multi-user.target" ];
  };
}
