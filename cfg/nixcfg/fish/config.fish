set -g fish_greeting

function glog
    git log --graph --decorate --all --pretty=format:'%C(auto)%h%d %C(#888888)(%an; %ar)%Creset %s'
end

function kb-toggle
    set -l STATUS_FILE "$XDG_RUNTIME_DIR/keyboard.status"

    if not test -f $STATUS_FILE
        echo "true" > $STATUS_FILE
        hyprctl notify -1 2500 "rgb(ff0000)" "fontsize:16 Enabled Keyboard"
        hyprctl keyword '$LAPTOP_KB_ENABLED' "true" -r
    else
        set current_status (cat $STATUS_FILE)
        if test $current_status = "true"
            echo "false" > $STATUS_FILE
            hyprctl notify -1 2500 "rgb(ff0000)" "fontsize:16 Disabled Keyboard"
            hyprctl keyword '$LAPTOP_KB_ENABLED' "false" -r
        else
            echo "true" > $STATUS_FILE
            hyprctl notify -1 2500 "rgb(ff0000)" "fontsize:16 Enabled Keyboard"
            hyprctl keyword '$LAPTOP_KB_ENABLED' "true" -r
        end
    end
end

function kb-status
    set -l STATUS_FILE "$XDG_RUNTIME_DIR/keyboard.status"
    if test -f $STATUS_FILE
        cat $STATUS_FILE
    else
        echo "unknown"
    end
end

if status is-interactive
    fortune
end

# bun
set -g fish_user_paths $HOME/.bun/bin $fish_user_paths
# bun end
