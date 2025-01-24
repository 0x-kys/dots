{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/packages.nix
    ./modules/files.nix
    ./modules/programs.nix
    ./modules/config.nix
  ];

  home = {
    username = "syk";
    homeDirectory = "/home/syk";
    stateVersion = "24.11";
  };
}
