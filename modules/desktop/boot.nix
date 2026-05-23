{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "uinput" "tcp_bbr" ];
    kernelParams = [
      "i915.enable_fbc=1"
      "usbhid.quirks=0x1c4f:0x0034:0x00000400"
    ];
    kernel.sysctl = {
      "vm.swappiness"                   = 10;
      "vm.vfs_cache_pressure"           = 50;
      "vm.dirty_ratio"                  = 10;
      "vm.dirty_background_ratio"       = 5;
      "net.core.default_qdisc"          = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_fastopen"           = 3;
      "kernel.sched_autogroup_enabled"  = 1;
    };
    initrd = {
      systemd.enable = true;
      compressor = "zstd";
    };
    extraModprobeConfig = ''
      options rtw88_8821ce rtw_power_mgnt=0
    '';
  };
}
