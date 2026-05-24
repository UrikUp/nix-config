{ pkgs, ...}:
{
  home.packages = with pkgs; [
    # gui
    vscode
    pgadmin4-desktopmode
    adminer
    bruno
    zeal # offline documenation
    sniffnet

    # tui
    presenterm
    wifitui
    pdf-cli
    ffmpeg
    uv

    # dependencies and runtimes
    php83 php83Packages.composer
    android-tools
    (python3.withPackages (ps: with ps; [ requests numpy pandas ]))

    ruff ty # for python
    vscode-langservers-extracted # for html and django templates
  ];
  
}
