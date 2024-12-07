{ pkgs, ... }:
{
  environment = {
    variables = {
      XCURSOR_SIZE = "16";
    };

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/syk/.steam/root/compatibilitytools.d";
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
      lutris
      bottles
      lxappearance           
      papirus-icon-theme     
      whitesur-cursors       
      mojave-gtk-theme
    ];
  };
}
