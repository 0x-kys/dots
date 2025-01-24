{config, ...}: let
  configPaths = [
    {
      name = "nvim";
      path = "${config.home.homeDirectory}/.config/nixcfg/nvim";
    }
    {
      name = "dunst";
      path = "${config.home.homeDirectory}/.config/nixcfg/dunst";
    }
    {
      name = "ghostty";
      path = "${config.home.homeDirectory}/.config/nixcfg/ghostty";
    }
    # {
    # name = "fish";
    # path = "${config.home.homeDirectory}/.config/nixcfg/fish";
    # }
    # {
    #   name = "nushell";
    #   path = "${config.home.homeDirectory}/.config/nixcfg/nushell";
    # }
    {
      name = "glow";
      path = "${config.home.homeDirectory}/.config/nixcfg/glow";
    }
    {
      name = "hypr";
      path = "${config.home.homeDirectory}/.config/nixcfg/hypr";
    }
    {
      name = "waybar";
      path = "${config.home.homeDirectory}/.config/nixcfg/waybar";
    }
    {
      name = "wofi";
      path = "${config.home.homeDirectory}/.config/nixcfg/wofi";
    }
    {
      name = "scripts";
      path = "${config.home.homeDirectory}/.config/nixcfg/scripts";
    }
    {
      name = "btop";
      path = "${config.home.homeDirectory}/.config/nixcfg/btop";
    }
    {
      name = "kanshi";
      path = "${config.home.homeDirectory}/.config/nixcfg/kanshi";
    }
  ];
in {
  xdg.configFile = builtins.listToAttrs (map (c: {
      name = c.name;
      value = {
        source = config.lib.file.mkOutOfStoreSymlink c.path;
      };
    })
    configPaths);

  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 96;
  };
}
