{pkgs, ...}: {
  environment = {
    variables = {
      XCURSOR_SIZE = "16";
    };

    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.xorg.libX11}/lib:${pkgs.xorg.libxcb}/lib:${pkgs.glib}/lib:${pkgs.glibc}/lib:${pkgs.libGL}/lib:${pkgs.libGLU}/lib:${pkgs.libGLX}/lib:$LD_LIBRARY_PATH";
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/syk/.steam/root/compatibilitytools.d";
    };

    systemPackages = with pkgs; [
      glibc
      glib
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
      libGL
      libGLU
      libGLX
      glxinfo
      vulkan-tools
      libgcc
      gnumake
      luarocks
      dnsutils
      cudatoolkit
      pciutils
      cmake
      ffmpeg
      v4l-utils
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      lutris
      bottles
      lxappearance
      papirus-icon-theme
      whitesur-cursors
      mojave-gtk-theme
    ];
  };
}
