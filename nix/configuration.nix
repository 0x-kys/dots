{ config, pkgs, ... }:

{
  imports = [ 
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
    };
  };

  time = {
    timeZone = "Asia/Kolkata";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";    
    };
  };

  services = {
    xserver = {
      enable = true;
      autorun = true;
      videoDrivers = [ "nvidia" ];
      displayManager = {
        lightdm = {
          enable = true;
        }; 
        # startx = {
        #   enable = true;
        # };
      };
      desktopManager = {
        xfce = {
          enable = true;
        };
      };
      windowManager = {
        spectrwm = {
          enable = true;
        };
      };
      dpi = 96;
      upscaleDefaultCursor = true;
      exportConfiguration = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      # enable touchpad support
      # libinput = {
      #   enable = true;
      # }; 
    };
    printing = {
      enable = true;
    }; 
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };
      # for jack applications
      # jack = {
      #   enable = true;
      # };
    };
    openssh = {
      enable = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting = {
        enable = true;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  security = { 
    rtkit = {
      enable = true;
    };
  };

  programs = {
    firefox = {
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

  users = {
    defaultUserShell = pkgs.fish;
    users = { 
      syk = {
      isNormalUser = true;
      description = "syk";
      extraGroups = [ "networkmanager" "wheel" "video" ];
      packages = with pkgs; [
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
        rofi        
        i3lock      
        xlockmore   
        spectrwm    
        zls         
        vscode-langservers-extracted 
        astro-language-server
        typescript-language-server
        svelte-language-server
        eslint
        pyright
        bash-language-server
        nixd
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

        # Other utilities
        # tiramisu    
        ];
      };
    };
  };

  environment = {
    variables = {
      XCURSOR_SIZE = "16";
    };

    systemPackages = with pkgs; [
      udiskie  
      git      
      zip      
      unzip    
      wget     
      curl     
      xclip    
      hsetroot 
      ripgrep  
      alsa-utils  
      xscreensaver  
      xorg.xinit    
      xorg.libxcb   
      xorg.libX11   
      libgcc        
      gnumake       
      luarocks      
      dnsutils      
      cmake         
      ffmpeg        
      v4l-utils     
      xdg-desktop-portal   
      xdg-desktop-portal-gtk  
      lxappearance           
      papirus-icon-theme     
      whitesur-cursors       
      mojave-gtk-theme
    ];
  };

  fonts = {
    fontconfig = {
      enable = true;
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];
  };

  system.stateVersion = "24.11"; 
}
