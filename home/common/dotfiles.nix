# home/common/dotfiles.nix
# Возможность внутри Desktop горячо обновлять конфиг
# На сервере через switch
{ liveEditable ? false }:
{ config, lib, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
  repoDots = ../dotfiles;
  localDots = "/home/urik/nix/home/dotfiles";
  source = path:
    if liveEditable
    then link "${localDots}/${path}"
    else "${repoDots}/${path}";
in {
  xdg.configFile = {
    "tmux/tmux.conf".source    = source "tmux/tmux.conf";
    # "niri/config.kdl".source   = source "niri/config.kdl";
    # "helix/config.toml".source = source "helix/config.toml";
  };
}
