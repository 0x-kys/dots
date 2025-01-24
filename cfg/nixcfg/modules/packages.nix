{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      newsflash
      (prismlauncher.override {jdks = [jdk8 jdk17 jdk21];})

      remmina
      kanshi
      nwg-displays
      waypaper

      brave
      neovim
      spotify
      ghostty
      libreoffice
      zed-editor
      obsidian

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
      alejandra
      nixd
      nil

      grim
      slurp

      whitesur-cursors
      colloid-gtk-theme
      kanagawa-gtk-theme
      zuki-themes
      graphite-gtk-theme
      papirus-icon-theme
      nwg-look
    ];
  };
}
