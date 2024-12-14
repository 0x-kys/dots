# dsbl greeter
set -g fish_greeting
# dsbl greeter end

# jb fix
set -x _JAVA_AWT_WM_NONREPARENTING 1
# jb fix end

# them paths
set -gx PATH /opt/cuda/bin $PATH
set -gx PATH $HOME/go/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
# them paths end

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
# bun end

# rustup
set -gx PATH /usr/lib/rustup/bin/ $PATH
# rustup end

# base editor #
if type -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
else if type -q vim
    set -gx EDITOR vim
    set -gx VISUAL vim
else if type -q vi
    set -gx EDITOR vi
    set -gx VISUAL vi
else if type -q nano
    set -gx EDITOR nano
    set -gx VISUAL nano
end
# base editor end #

# prompt (fisher install jorgebucaran/hydro)
set --universal hydro_fetch true
set --universal hydro_multiline true
# prompt end

if status is-interactive
  pokemon-colorscripts -r
  fortune

  function glog
    git log --graph --decorate --all --pretty=format:'%C(auto)%h%d %C(#888888)(%an; %ar)%Creset %s'
  end

  function dnd
    xfconf-query -c xfce4-notifyd -p /do-not-disturb --toggle
  end

  function isdnd
    xfconf-query -c xfce4-notifyd -p /do-not-disturb -v 2>/dev/null
  end

  function kode-chaos
    tokei . --sort code --exclude "*.json" --exclude "*.yaml" --exclude "*.xml" --exclude "*.svg"
  end

  function caff
    command caffeine start > /dev/null 2>&1 &
    disown
    xset -dpms
    xset s off
  end

  function iscaff
    if pgrep -f caffeine > /dev/null
        echo "true" 
    else
        echo "false" 
    end
  end

  function uncaff
    caffeine kill
    xset +dpms
    xset s on
  end
end
