set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set --export EDITOR nvim

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $HOME/.cargo/bin $PATH
set --export ANDROID_HOME "$HOME/Android/Sdk"
set --export PATH "$HOME/go/bin" $PATH

set --export PATH $ANDROID_HOME/emulator $PATH
set --export PATH $ANDROID_HOME/platform-tools $PATH
set --export PATH $ANDROID_HOME/cmdline-tools/latest/bin $PATH

source "$HOME/.cargo/env.fish"
starship init fish | source

# uv
fish_add_path "/home/syk/.local/bin"
set -gx PATH ~/.config/emacs/bin $PATH
