{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/default.nix
    inputs.home-manager.nixosModules.default
  ];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "syk" = import ./home.nix;
    };
  };

  system.stateVersion = "24.11";
}
