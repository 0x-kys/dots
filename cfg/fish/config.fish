export _JAVA_AWT_WM_NONREPARENTING=1

set -gx PATH /opt/cuda/bin $PATH
set -g LD_LIBRARY_PATH /opt/cuda/lib64 $LD_LIBRARY_PATH

if status is-interactive
end
