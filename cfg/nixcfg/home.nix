{ config, pkgs, ... }:

let
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
    {
      name = "fish";
      path = "${config.home.homeDirectory}/.config/nixcfg/fish";
    }
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
  home = {
    username = "syk";
    homeDirectory = "/home/syk";

    file = {
      ".icons/WhiteSur-cursors" = {
        source = "${pkgs.whitesur-cursors}/share/icons/WhiteSur-cursors";
        recursive = true;
      };

      ".tmux.conf" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.config/nixcfg/tmux/.tmux.conf";
      };
    };

    packages = with pkgs; [
      newsflash
      (prismlauncher.override { jdks = [ jdk8 jdk17 jdk21 ]; })

      remmina
      kanshi
      waypaper

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
      golangci-lint
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
  };

  xdg.configFile = builtins.listToAttrs (map (c: {
    name = c.name;
    value = { source = config.lib.file.mkOutOfStoreSymlink c.path; };
  }) configPaths);

  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 96;
  };

  programs = {
    git = { enable = true; };
    home-manager = { enable = true; };
  };

  home.stateVersion = "24.11";
}
