{ ... }:
{
  imports = [ 
    ./hardware-configuration.nix
    ./modules/default.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "24.11"; 
}
