{...}: {
  programs = {
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
      };
    };

    gamemode = {
      enable = true;
    };

    dconf = {
      enable = true;
    };

    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    nix-ld = {
      enable = true;
    };

    fish = {
      enable = true;
    };
  };

  xdg = {
    portal = {
      config = {
        common = {
          default = "*";
        };
      };
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
