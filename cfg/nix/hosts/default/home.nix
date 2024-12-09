{pkgs, ...}: {
  home = {
    username = "syk";
    homeDirectory = "/home/syk";
    stateVersion = "24.11";
  };

  home.packages =
    (import ../../modules/home-manager/alias.nix {inherit pkgs;})
    ++ (
      with pkgs; [
        # Desktop Environment Tools
        cheese
        sakura
        wezterm
        picom
        btop
        pfetch
        fastfetch
        flameshot
        nitrogen

        # Applications
        brave
        spotify
        vesktop
        libreoffice
        vlc

        # Development tools
        vim
        neovim
        zed-editor
        rofi
        i3lock
        xlockmore
        spectrwm
        zls
        lua-language-server
        vscode-langservers-extracted
        astro-language-server
        typescript-language-server
        svelte-language-server
        eslint
        pyright
        bash-language-server
        nixd
        nixpkgs-fmt
        alejandra
        marksman
        tmux
        zig
        rustup
        python313
        go
        gcc
        bun
        corepack
        nodejs_22

        # Fish shell plugins and tools
        fishPlugins.done
        fishPlugins.fzf-fish
        fishPlugins.forgit
        fishPlugins.hydro
        fzf
        fishPlugins.grc
        grc

        # XFCE components
        xfce.ristretto
        xfce.thunar
        xfce.thunar-volman
        xfce.thunar-archive-plugin
        xfce.thunar-media-tags-plugin

        # Games
        prismlauncher
        mangohud
        protonup

        # Other utilities
        # tiramisu
      ]
    );

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Liberation Serif"];
        sansSerif = ["Ubuntu"];
        monospace = ["JetBrains Mono Nerd Font"];
      };
    };
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/syk/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "neovim";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs.home-manager.enable = true;
}
