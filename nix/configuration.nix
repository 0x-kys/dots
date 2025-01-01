# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

boot.resumeDevice = "/dev/disk/by-uuid/86d44430-3a9b-407e-8f33-08909906253c"; # Replace with your swap partition; use 'lsblk' to find it

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/06C899D072155E29";  # Using UUID for more persistent identification
    fsType = "ntfs-3g";  # Use ntfs-3g for write support
    options = [ "rw" "uid=1000" "gid=100" "dmask=022" "fmask=133" ];  
  };

 # Optional: For better performance, you might want to tweak your kernel parameters
  boot.kernelParams = [ "amdgpu.dc=1" "mem_sleep_default=deep" ];  # Enable DC (Display Core) for better performance

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs-3g" ];

  networking.hostName = "nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];

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

    # Enable AMD microcode updates for CPU performance and security
  hardware.cpu.amd.updateMicrocode = true;

  # Configure GPU support
  services.xserver.videoDrivers = [ "amdgpu" ];


  # Enable hardware acceleration for video playback
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # For OpenCL support with Vega GPUs (optional if needed)
  hardware.graphics.extraPackages = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
  ];

  # If you need to use VA-API for video acceleration
  hardware.graphics.extraPackages32 = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  programs.fish.enable = true;

  services.udisks2.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.syk = {
    isNormalUser = true;
    description = "syk";
    extraGroups = [ "networkmanager" "wheel" "storage" "plugdev" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      brave
      ghostty
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    jq
    vim
    curl
    wget
    go
    tmux
    nodejs
    bun
    nodePackages.nodejs
    corepack
    rustup
    gcc
    clang
    zig
    git
    zip
    unzip
    cmake
    fish
    wofi
    slurp
    dunst
    obs-studio
    obs-studio-plugins.wlrobs
    obs-studio-plugins.obs-pipewire-audio-capture
    pywal
    waybar
    neovim
    fortune
    python3
    hyprpaper
    hyprshot
    wl-clipboard
    wl-clip-persist
    swaylock-effects
    whitesur-cursors
    libreoffice
    glow
    bat
    btop
    spotify
    fastfetch
    brightnessctl
    fishPlugins.hydro
    helvum
    playerctl
    lua-language-server
    marksman
    zls
    svelte-language-server
    pyright
    rust-analyzer
    tailwindcss-language-server
    vscode-langservers-extracted
    typescript-language-server
    gopls
    golangci-lint-langserver
    wf-recorder
    kanagawa-gtk-theme
    kanagawa-icon-theme
    gnome-tweaks
    lxappearance
    nwg-look
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.iosevka
  ]; 

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  security.polkit.enable = true;

  systemd.services.lock-before-sleep = {
  description = "Lock screen before suspend or hibernate";
  before = [ "sleep.target" "hibernate.target" ];
  wantedBy = [ "sleep.target" "hibernate.target" ];
  serviceConfig.Type = "oneshot";
  script = ''
    ${pkgs.swaylock}/bin/swaylock --screenshots --clock --indicator --effect-blur 7x5 --fade-in 0.1
  '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
