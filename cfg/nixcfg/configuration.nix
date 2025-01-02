{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.resumeDevice = "/dev/disk/by-uuid/86d44430-3a9b-407e-8f33-08909906253c"; # Replace with your swap partition; use 'lsblk' to find it & use `sudo blkid /dev/swap/parition` to find UUID

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/06C899D072155E29";
    fsType = "ntfs-3g";  # Use ntfs-3g for NTFS support
    options = [ "rw" "uid=1000" "gid=100" "umask=007" "dmask=007" "fmask=117" ];
  };

 # Optional For better performance
  boot.kernelParams = [ "amdgpu.dc=1" "mem_sleep_default=deep" ];  # Enable DC (Display Core) for better performance

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs-3g" ];

  networking.hostName = "nix"; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

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

  hardware.cpu.amd.updateMicrocode = true;

  services.xserver.videoDrivers = [ "amdgpu" ];


  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.graphics.extraPackages = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
  ];

  hardware.graphics.extraPackages32 = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  programs.fish.enable = true;

  services.udisks2.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.users.syk = {
    isNormalUser = true;
    description = "syk";
    extraGroups = [ "networkmanager" "wheel" "storage" "plugdev" ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.variables.EDITOR = "nvim";

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  environment.systemPackages = with pkgs; [
    vim
    curl
    wget
    fish
    wofi
    slurp
    dunst
    pywal
    waybar
    hyprpaper
    hyprshot
    wl-clipboard
    wl-clip-persist
    swaylock-effects
    brightnessctl
    fishPlugins.hydro
    helvum
    playerctl
    wf-recorder
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.iosevka
  ]; 

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;

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

  # Before changing this value read the documentation for this option
  #
  #   man configuration.nix
  #   https://nixos.org/nixos/options.html
  system.stateVersion = "24.11"; # Did you read the comment?
}
