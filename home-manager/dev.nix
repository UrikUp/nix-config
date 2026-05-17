{ pkgs, ...}:
{
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      requests
      numpy
      pandas
    ]))
    vscode
    pgadmin4-desktopmode
    adminer
  ];
}
