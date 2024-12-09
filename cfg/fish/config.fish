export _JAVA_AWT_WM_NONREPARENTING=1

set -gx PATH /opt/cuda/bin $PATH
set -gx PATH $HOME/go/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
# set -g LD_LIBRARY_PATH /nix/store/gvb5mha0ly23nkfygl64v71r60sqczbc-system-path/lib/ $LD_LIBRARY_PATH

set -gx DIRENV_ALLOW 1

if status is-interactive
  alias qwenc 'function _qwenc; ollama run qwen2.5-coder p "$argv"; ollama stop qwen2.5-coder; end; _qwenc' 
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

# direnv integration
# direnv hook fish | source
eval (direnv hook fish)
