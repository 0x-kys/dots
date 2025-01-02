{ config, pkgs, ... }:

{
  home.username = "syk";
  home.homeDirectory = "/home/syk";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # Neovim Config
  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };

  # Ghostty config
  home.file.".config/ghostty" = {
    source = ./ghostty;
    recursive = true;
  };

  # Fish Config
  home.file.".config/fish" = {
    source = ./fish;
    recursive = true;
  };

  home.file.".config/glow" = {
    source = ./glow;
    recursive = true;
  };

  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
  };

  home.file.".config/btop" = {
    source = ./btop;
    recursive = true;
  };

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
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
    nixfmt-classic
  ];

  programs = {
    git = {
      enable = true;
    };

    home-manager = {
      enable = true;
    };
  };

  home.stateVersion = "24.11";
}
