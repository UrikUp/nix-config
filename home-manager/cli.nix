{ pkgs, ... }: {

  home.packages = with pkgs; [
    stow
    eza
    fd
    uv
    ffmpeg
    gh
    p7zip
    mosh
    evil-helix
    jq
    presenterm
    android-tools
    ripgrep
    lazygit
    btop
    grc
    php83
    php83Packages.composer
    wifitui
    devenv
    pdf-cli
    wget
    ruff ty # for python
    vscode-langservers-extracted # for html and django templates
    bruno
    tldr
    unzip
    zip
  ];

  
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
        "grc"
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
    tmux = {
      enable = true;
      # catppuccin.enable = true;
      mouse = true;
      baseIndex = 1;
      keyMode = "vi";
      # shell = "fish";
      # shortcut = "a";   # ctrl+a instead of ctrl+b
      terminal = "tmux-256color";
      extraConfig = ''
        set -ag terminal-overrides ",*:RGB"
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
      '';
    };

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
