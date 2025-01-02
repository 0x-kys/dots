set -g fish_greeting

# prompt
set --universal hydro_fetch true
set --universal hydro_multiline true
# prompt end

if status is-interactive
    fortune

    function glog
        git log --graph --decorate --all --pretty=format:'%C(auto)%h%d %C(#888888)(%an; %ar)%Creset %s'
    end
end
