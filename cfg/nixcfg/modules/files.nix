{
  config,
  pkgs,
  ...
}: {
  home = {
    file = {
      ".icons/WhiteSur-cursors" = {
        source = "${pkgs.whitesur-cursors}/share/icons/WhiteSur-cursors";
        recursive = true;
      };

      ".tmux.conf" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.config/nixcfg/tmux/.tmux.conf";
      };

      "${config.home.homeDirectory}/.config/starship.toml" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.config/nixcfg/starship/starship.toml";
      };
    };
  };
}
