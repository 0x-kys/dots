export _JAVA_AWT_WM_NONREPARENTING=1

set -gx PATH /opt/cuda/bin $PATH
set -gx PATH $HOME/go/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -g LD_LIBRARY_PATH /opt/cuda/lib64 $LD_LIBRARY_PATH

if status is-interactive
  alias todo="nvim ~/.stuff.md"
  alias qwenc 'function _qwenc; ollama run qwen2.5-coder p "$argv"; ollama stop qwen2.5-coder; end; _qwenc'
  alias ff="fastfetch --logo arch2"
  alias glog="git log --graph --decorate --all --pretty=format:'%C(auto)%h%d %C(#888888)(%an; %ar)%Creset %s'"
end

# pnpm
set -gx PNPM_HOME "/home/syk/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# cargo
set -gx PATH $HOME/.cargo/bin $PATH

# rustup
set -gx PATH /usr/lib/rustup/bin/ $PATH
