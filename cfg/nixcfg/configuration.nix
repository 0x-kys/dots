{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  fileSystems = {
    "/run/media/syk/hdd" = {
      device = "/dev/sda1";
      fsType = "exfat";
      options = [
        "defaults"
        "x-gvfs-show"
        "uid=1000"
        "gid=100"
        "dmask=007"
        "fmask=117"
      ];
    };
  };

  boot = {
    resumeDevice =
      "/dev/disk/by-uuid/7e9f1c2e-2b3f-4540-842f-5d09d2b17e20"; # Replace with your swap partition; use 'lsblk' to find it & use `sudo blkid /dev/swap/parition` to find UUID

    kernelParams = [
      "amdgpu.dc=1"
      "mem_sleep_default=deep"
    ]; # Enable DC (Display Core) for better performance

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 7;
      };

      efi = { canTouchEfiVariables = true; };
    };
  };

  networking = {
    hostName = "nix";

    wireless = { enable = false; };

    networkmanager = { enable = true; };

    firewall = {
      enable = true;
      # allowedUDPPorts = [ ... ]; 
      # allowedTCPPorts = [ ... ];
    };
  };

  time = { timeZone = "Asia/Kolkata"; };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];

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

  security = {
    rtkit = { enable = true; };
    polkit = { enable = true; };
  };

  hardware = {
    cpu = { amd = { updateMicrocode = true; }; };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl ];
      extraPackages32 = with pkgs; [ vaapiIntel vaapiVdpau libvdpau-va-gl ];
    };
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager = { gnome = { enable = true; }; };

      xkb = {
        layout = "us";
        variant = "";
      };
    };

    udisks2 = { enable = true; };
    printing = { enable = true; };

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse = { enable = true; };
      jack = { enable = false; };

      # media-session.enable = true;
      wireplumber = { enable = true; };
    };

    pulseaudio = { enable = false; };
    openssh = { enable = true; };

    # touchpad support
    libinput = { enable = true; };
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland = { enable = true; };
    };

    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    fish = { enable = true; };
    mtr = { enable = true; };
    nix-ld = { enable = true; };
  };

  users = {
    users = {
      syk = {
        isNormalUser = true;
        description = "syk";
        extraGroups =
          [ "networkmanager" "wheel" "storage" "plugdev" "video" "audio" ];
        shell = pkgs.fish;
      };
    };
  };

  nixpkgs = { config = { allowUnfree = true; }; };

  environment = {
    sessionVariables = { NIXOS_OZONE_WL = "1"; };
    variables = { EDITOR = "nvim"; };

    systemPackages = with pkgs; [
      vim
      curl
      wget
      fish
      fishPlugins.async-prompt
      fishPlugins.pure
      wofi
      dunst
      pywal
      waybar
      hyprpaper
      wl-clipboard
      wl-clip-persist
      swaylock-effects
      brightnessctl
      helvum
      pavucontrol
      playerctl
      wf-recorder
    ];
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    };
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      corefonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts._0xproto
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      font-awesome
    ];
  };

  # Before changing this value read the documentation for this option
  #
  #   man configuration.nix
  #   https://nixos.org/nixos/options.html
  system = { stateVersion = "24.11"; };
}
