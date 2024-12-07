{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
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

  services.xserver.videoDrivers = ["nvidia"];

  services.xserver.enable = true;
  services.xserver.autorun = true;
  #services.xserver.displayManager.startx.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.windowManager.spectrwm.enable = true;

  services.xserver.dpi = 96;
  services.xserver.upscaleDefaultCursor = true;
  environment.variables = {
    XCURSOR_SIZE = "16";
  };

  services.xserver.exportConfiguration = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  # for jack applications
  #services.jack.enable = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  security.rtkit.enable = true;

  programs.nix-ld.enable = true;
  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  users.users.syk = {
    isNormalUser = true;
    description = "syk";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      cheese
      sakura
      wezterm
      picom
      btop
      pfetch
      fastfetch
      flameshot
      nitrogen
      brave
      spotify
      vesktop
      libreoffice
      vlc
      zig
      rustup
      python313
      go
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.hydro
      fzf
      fishPlugins.grc
      grc   
    ];
  };

  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  nixpkgs.config.allowUnfree = true;

  xdg.portal.config.common.default = "*";

  # xdg.portal.enable = true;
  # xdg.portal.xdgOpenUsePortal = true;
  # xdg.portal.extraPortals = [
  #  pkgs.xdg-desktop-portal-gtk
  # ];


      environment.systemPackages = with pkgs; [
    udiskie
    git
    zip
    vim
    rofi
    wget
    curl
    unzip
    xclip
    neovim
    hsetroot
    ripgrep
    spectrwm
    i3lock
    xlockmore
    alsa-utils
    xscreensaver
    xorg.xinit
    xorg.libxcb
    xorg.libX11
    libgcc
    gnumake
    dnsutils
    cmake
    tmux
    ffmpeg
    v4l-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xfce.ristretto
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    tiramisu
    lxappearance
    papirus-icon-theme
    whitesur-cursors
    mojave-gtk-theme
  ];

  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
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



  services.openssh.enable = true;
  system.stateVersion = "24.11"; 
}
