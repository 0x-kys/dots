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

  function keyb-tog
    set INTERNAL_KEYBOARD "AT Translated Set 2 keyboard"

    # Get the current state of the internal keyboard
    set -l current_state (xinput --list-props "$INTERNAL_KEYBOARD" | grep "Device Enabled" | awk '{print $4}')

    if [ "$current_state" = "1" ]  # If the keyboard is enabled
      xinput --set-prop "$INTERNAL_KEYBOARD" "Device Enabled" 0
      echo "Internal keyboard disabled."
    else  # If the keyboard is disabled
      xinput --set-prop "$INTERNAL_KEYBOARD" "Device Enabled" 1
      echo "Internal keyboard enabled."
    end
  end

  function brightness
    if test (count $argv) -gt 0
      set -l percentage $argv[1]
      if test $percentage -ge 0 -a $percentage -le 100
        brightnessctl set $percentage%
      else
        echo "Please enter a percentage value between 0 and 100."
      end
    else
      echo "Usage: brightness <percentage>"
    end
  end

  function keyb-status
    set INTERNAL_KEYBOARD "AT Translated Set 2 keyboard"

    set -l current_state (xinput --list-props "$INTERNAL_KEYBOARD" | grep "Device Enabled" | awk '{print $4}')

    if [ "$current_state" = "1" ]  
      echo "Keyboard: enabled"
    else  
      echo "keyboard: disabled"
    end
  end

  function pgsql
    psql -U postgres
  end

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
