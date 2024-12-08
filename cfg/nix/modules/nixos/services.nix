{ ... }:
{
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
    ollama = {
      enable = true;
      acceleration = "cuda";
    };
  };
}
