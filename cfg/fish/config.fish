export _JAVA_AWT_WM_NONREPARENTING=1

set -gx PATH /opt/cuda/bin $PATH
set -gx PATH $HOME/go/bin $PATH
set -gx PATH $HOME/.local/bin $PATH

# pnpm
set -gx PNPM_HOME "/home/syk/.local/share/pnpm"
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

if status is-interactive
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
    caffeine start &
    disown (pidof caffeine-ng)
    echo "safe to leave this shell"
  end

  function iscaff
    if pgrep -f caffeine > /dev/null
        echo "true" 
    else
        echo "false" 
    end
  end

  function get-real
    if test (isdnd) = "false"
      dnd
      echo "DND on"
    end

    if test (iscaff) = "false"
      caff
      echo "CAFF on"
    end
  end

  function get-fake
    if test (isdnd) = "true"
      dnd
      echo "DND off"
    end

    if test (iscaff) = "true"
      uncaff
      echo "CAFF off"
    end
  end

  function uncaff
    caffeine kill
  end
end
