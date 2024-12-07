{ config, pkgs, ... }:
{
  imports = [
    ./services.nix
    ./hardware.nix
    ./programs.nix
    ./i18n.nix
    ./fonts.nix
    ./environment.nix
    ./users.nix
    ./security.nix
    ./networking.nix
    ./time.nix
    ./boot.nix
  ];
}
