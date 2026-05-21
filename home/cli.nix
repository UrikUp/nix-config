{ pkgs, config, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
  dots = "/home/urik/nix/home/dotfiles";
in
{
  home.packages = with pkgs; [
    stow
    eza    
    fd
    gh
    mosh
    evil-helix
    jq
    ripgrep
    lazygit
    btop
    devenv
    wget
    tldr
    p7zip unzip zip
    fastfetch
    tmux
  ];

  xdg.configFile."tmux/tmux.conf".source = link "${dots}/tmux/tmux.conf";
  programs = {
    direnv = {
      enable = true;
      enableFishIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        zoxide init fish --cmd cd | source
        fzf --fish | source
      '';
     plugins = map (p: { name = p; src = pkgs.fishPlugins.${p}.src; }) [
        "tide"
        "fzf-fish"
        "autopair"
        "done"
        # "sponge" # get irritating when fixing commands
        "colored-man-pages"
        "puffer" # makes ... -> ../..
      ];
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    # starship = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    yazi = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        manager = {
          show_hidden = true;
          sort_by = "natural";
          sort_dir_first = true;
        };
      };
    };
    # tmux = {
      # enable = true;
      # # catppuccin.enable = true;
      # mouse = true;
      # baseIndex = 1;
      # keyMode = "vi";
      # # shell = "fish";
      # # shortcut = "a";   # ctrl+a instead of ctrl+b
      # terminal = "tmux-256color";
      # extraConfig = ''
      #   set -ag terminal-overrides ",*:RGB"
      #   bind | split-window -h -c "#{pane_current_path}"
      #   bind - split-window -v -c "#{pane_current_path}"
      # '';
    # };
    

    bat = {
      enable = true;
      # catppuccin.enable = true; # doesn't exits
      config = {
        style = "numbers,changes,header";
        wrap = "never";
      };
    };
    git = {
      enable = true;
      settings = {
        credential.helper = "!gh auth git-credential";
        user = {
          name = "UrikUp";
          email = "975urikup@gmail.com";
        };
        delta = {
          navigate = true;
          side-by-side = true;
        };
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    diff-so-fancy.enable = false;
  };
  
}

