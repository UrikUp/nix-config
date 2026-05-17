{pkgs, ...}: {

# audio
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;  # if you need JACK
};
# bluetooth
hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;
hardware.enableAllFirmware = true;

# systemd.services.rfkill-unblock-bluetooth = {
#   description = "Unblock Bluetooth via rfkill";
#   wantedBy = [ "bluetooth.target" ];
#   before = [ "bluetooth.service" ];
#   serviceConfig = {
#     Type = "oneshot";
#     ExecStart = "${pkgs.util-linux}/bin/rfkill unblock bluetooth";
#   };
# };
services.gvfs.enable = true;  # Trash, network shares, MTP devices
services.tumbler.enable = true;  # Thumbnail generation

# boot.kernelParams = [
#   "quiet"
#   "intel_pstate=active"
#   "i915.enable_psr=0"
#   "i915.enable_fbc=1"
#   "pcie_aspm=force"
#   "mitigations=auto"
# ];

services.upower.enable = true;
services.thermald.enable = true;
services.auto-cpufreq.enable = true;
services.power-profiles-daemon.enable = false;

# boot and general optimization
 boot.initrd.systemd.enable = true;
 boot.initrd.compressor = "zstd";
 # boot.initrd.compressorArgs = [ "-19" "-T0" ]; # max compression, all threads

 # systemd.services.NetworkManager-wait-online.enable = false; # it broke bluetooth

 zramSwap = {
    enable = true;
    algorithm = "lz4"; # lzo, lz4hc, lz4, zstd
    memoryPercent = 50; # default is 50, tune to taste
    priority = 100;
  };

 boot.kernel.sysctl = {
  # Memory
  "vm.swappiness" = 10;
  "vm.vfs_cache_pressure" = 50;
  "vm.dirty_ratio" = 10;
  "vm.dirty_background_ratio" = 5;

  # Network (if you care about latency/throughput)
  "net.core.default_qdisc" = "fq";
  "net.ipv4.tcp_congestion_control" = "bbr"; # needs kernel module
  "net.ipv4.tcp_fastopen" = 3;

  # Reduces scheduling latency (good for desktop)
  "kernel.sched_autogroup_enabled" = 1;
 };
}
