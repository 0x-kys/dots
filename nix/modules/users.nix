{ pkgs, ... }:
{
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
        mangohud
        protonup

        # Other utilities
        # tiramisu    
        ];
      };
    };
  };
}
