{ pkgs, ... }:
{
  environment = {
    variables = {
      XCURSOR_SIZE = "16";
      LD_LIBRARY_PATH = "${pkgs.xorg.libX11}/lib:$LD_LIBRARY_PATH";
    };

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/syk/.steam/root/compatibilitytools.d"; 
    };

    systemPackages = with pkgs; [
      glibc
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
      vulkan-tools
      libgcc        
      gnumake       
      luarocks      
      dnsutils      
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
