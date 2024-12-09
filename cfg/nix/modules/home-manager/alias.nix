{pkgs, ...}:
with pkgs; [
  (writeShellScriptBin "glog" ''
    git log --graph --decorate --all --pretty=format:'%C(auto)%h%d %C(#888888)(%an; %ar)%Creset %s'
  '')

  (writeShellScriptBin "dnd" ''
    xfconf-query -c xfce4-notifyd -p /do-not-disturb --toggle
  '')

  (writeShellScriptBin "is-dnd" ''
    xfconf-query -c xfce4-notifyd -p /do-not-disturb -v 2>/dev/null
  '')

  (writeShellScriptBin "nix-gc" ''
    sudo nix-collect-garbage -d
  '')

  (writeShellScriptBin "nix-conf" ''
    cd ~/.config/nix && nvim flake.nix
  '')

  (writeShellScriptBin "nix-rbs" ''
    sudo nixos-rebuild switch --flake ~/.config/nix#default
  '')
]
