{
boot.extraModprobeConfig = ''
  options rtw88_8821ce rtw_power_mgnt=0
'';
  networking.networkmanager = {
    wifi.powersave = false;
  };
}

