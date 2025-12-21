# Auto-load nvm on shell startup
function __nvm_auto_load --on-variable PWD
    set -l default_node_version (nvm version default 2>/dev/null)
    set -l node_version (nvm version 2>/dev/null)
    set -l nvmrc_path (nvm_find_nvmrc 2>/dev/null)
    
    if test -n "$nvmrc_path"
        set -l nvmrc_node_version (nvm version (cat $nvmrc_path) 2>/dev/null)
        if test "$nvmrc_node_version" = "N/A"
            nvm install (cat $nvmrc_path)
        else if test "$nvmrc_node_version" != "$node_version"
            nvm use $nvmrc_node_version >/dev/null 2>&1
        end
    else if test -n "$default_node_version" -a "$node_version" != "$default_node_version"
        nvm use default >/dev/null 2>&1
    end
end

# Initialize nvm on startup
__nvm_auto_load
