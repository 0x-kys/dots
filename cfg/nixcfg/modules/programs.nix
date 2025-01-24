{...}: {
  programs = {
    nushell = {
      enable = true;
      # configFile.source = ./nushell/config.nu;
      extraConfig = ''
        # Disable banner
        $env.config = {
          show_banner: false
        }

        # Toggle in-built keyboard
        def kb-toggle [] {
            let status_file = $"($env.XDG_RUNTIME_DIR)/keyboard.status"

            if not ($status_file | path exists) {
                "true" | save $status_file
                ^hyprctl notify -1 2500 "rgb(ff0000)" "fontsize:16 Enabled Keyboard"
                ^hyprctl keyword '$LAPTOP_KB_ENABLED' "true" -r
            } else {
                let current_status = open $status_file
                if $current_status == "true" {
                    "false" | save $status_file
                    ^hyprctl notify -1 2500 "rgb(ff0000)" "fontsize:16 Disabled Keyboard"
                    ^hyprctl keyword '$LAPTOP_KB_ENABLED' "false" -r
                } else {
                    "true" | save $status_file
                    ^hyprctl notify -1 2500 "rgb(ff0000)" "fontsize:16 Enabled Keyboard"
                    ^hyprctl keyword '$LAPTOP_KB_ENABLED' "true" -r
                }
            }
        }

        # Check status of in-built keyboard
        def kb-status [] {
            let status_file = $"($env.XDG_RUNTIME_DIR)/keyboard.status"
            if ($status_file | path exists) {
                open $status_file
            } else {
                echo "unknown"
            }
        }

        $env.PATH = ($env.PATH | prepend $"($env.HOME)/.bun/bin")
      '';
      shellAliases = {
        glog = "git log --graph --decorate --all --pretty=format:'%C(auto)%h%d %C(#888888)(%an; %ar)%Creset %s'";
      };
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    starship = {
      enable = true;
    };
    git = {
      enable = true;
    };
    home-manager = {
      enable = true;
    };
  };
}
