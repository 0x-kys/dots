{ config, pkgs, ... }:

let
  nvimPath = "${config.home.homeDirectory}/.config/nixcfg/nvim";
  ghosttyPath = "${config.home.homeDirectory}/.config/nixcfg/ghostty";
  fishPath = "${config.home.homeDirectory}/.config/nixcfg/fish";
  glowPath = "${config.home.homeDirectory}/.config/nixcfg/glow";
  hyprPath = "${config.home.homeDirectory}/.config/nixcfg/hypr";
  waybarPath = "${config.home.homeDirectory}/.config/nixcfg/waybar";
  scriptsPath = "${config.home.homeDirectory}/.config/nixcfg/scripts";
  btopPath = "${config.home.homeDirectory}/.config/nixcfg/btop";
in {
  home.username = "syk";
  home.homeDirectory = "/home/syk";

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
  xdg.configFile."ghostty".source =
    config.lib.file.mkOutOfStoreSymlink ghosttyPath;
  xdg.configFile."fish".source = config.lib.file.mkOutOfStoreSymlink fishPath;
  xdg.configFile."glow".source = config.lib.file.mkOutOfStoreSymlink glowPath;
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink hyprPath;
  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink waybarPath;
  xdg.configFile."scripts".source =
    config.lib.file.mkOutOfStoreSymlink scriptsPath;
  xdg.configFile."btop".source = config.lib.file.mkOutOfStoreSymlink btopPath;

  home.file = {
    ".icons/WhiteSur-cursors" = {
      source = "${pkgs.whitesur-cursors}/share/icons/WhiteSur-cursors";
      recursive = true;
    };
  };

  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 96;
  };

  home.packages = with pkgs; [
    brave
    neovim
    spotify
    ghostty
    libreoffice

    fastfetch
    tmux
    nnn

    zip
    xz
    unzip
    p7zip

    ripgrep
    jq
    yq-go
    eza
    fzf

    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    cowsay
    fortune
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    nix-output-monitor

    glow
    bat
    tmux
    tmuxPlugins.sensible
    tmuxPlugins.vim-tmux-navigator

    btop
    iotop
    iftop

    strace
    ltrace
    lsof

    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils

    go
    zig
    bun
    cmake
    clang
    rustup
    nodejs
    python3
    corepack

    obs-studio
    obs-studio-plugins.wlrobs
    obs-studio-plugins.obs-pipewire-audio-capture

    zls
    gopls
    pyright
    marksman
    lua-language-server
    golangci-lint-langserver
    vscode-langservers-extracted
    typescript-language-server
    tailwindcss-language-server
    svelte-language-server
    markdownlint-cli
    nixfmt-classic
    nixd

    grim
    slurp

    whitesur-cursors
    nwg-look
  ];

  programs = {
    git = { enable = true; };

    home-manager = { enable = true; };
  };

  home.stateVersion = "24.11";
}
