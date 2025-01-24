{pkgs, ...}: {
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

    helix = {
      enable = true;
      settings = {
        theme = "autumn_night_transparent";
        keys = {
          normal = {
            space = {
              space = "file_picker";
            };
            esc = ["collapse_selection" "keep_primary_selection"];
          };
        };
        editor = {
          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "warning";
          };
          gutters = {
            layout = ["diff" "diagnostics" "line-numbers" "spacer"];
            line-numbers = {
              min-width = 1;
            };
          };
          search = {
            smart-case = true;
            wrap-around = true;
          };
          soft-wrap = {
            enable = true;
            max-indent-retain = 0;
          };
          statusline = {
            left = ["mode" "version-control" "spinner"];
            center = ["file-name"];
            right = ["diagnostics" "selections" "position" "position-percentage" "file-encoding" "file-line-ending" "file-type"];
          };
          line-number = "relative";
          lsp = {
            display-messages = true;
          };
          indent-guides = {
            render = true;
            character = "╎"; # Some characters that work well: "▏", "┆", "┊", "⸽"
            skip-levels = 1;
          };
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          whitespace = {
            render = "all";
            characters = {
              space = " ";
              nbsp = "⍽";
              nnbsp = "␣";
              tab = "→";
              newline = "⏎";
              tabpad = " ";
            };
          };
        };
      };
      languages = {
        language = [
          # Nix
          {
            name = "nix";
            scope = "source.nix";
            file-types = ["nix"];
            auto-format = true;
            formatter.command = "${pkgs.alejandra}/bin/alejandra";
          }
          # Rust
          {
            name = "rust";
            scope = "source.rust";
            file-types = ["rs"];
            auto-format = true;
            formatter.command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          }
          # Lua
          {
            name = "lua";
            scope = "source.lua";
            file-types = ["lua"];
            auto-format = true;
            formatter.command = "${pkgs.lua-language-server}/bin/lua-format";
          }
          # HTML
          {
            name = "html";
            scope = "text.html.basic";
            file-types = ["html" "htm"];
            auto-format = true;
            formatter.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
          }
          # CSS
          {
            name = "css";
            scope = "source.css";
            file-types = ["css"];
            auto-format = true;
            formatter.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
          }
          # JavaScript
          {
            name = "javascript";
            scope = "source.js";
            file-types = ["js"];
            auto-format = true;
            formatter.command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
          }
          # JSX
          {
            name = "javascriptreact";
            scope = "source.js.jsx";
            file-types = ["jsx"];
            auto-format = true;
            formatter.command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
          }
          # TSX
          {
            name = "typescriptreact";
            scope = "source.tsx";
            file-types = ["tsx"];
            auto-format = true;
            formatter.command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
          }
          # Svelte
          {
            name = "svelte";
            scope = "source.svelte";
            file-types = ["svelte"];
            auto-format = true;
            formatter.command = "${pkgs.svelte-language-server}/bin/svelteserver";
          }
          # Astro
          {
            name = "astro";
            scope = "text.html.astro";
            file-types = ["astro"];
            auto-format = true;
            formatter.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server"; # Use HTML formatter for Astro
          }
          # Zig
          {
            name = "zig";
            scope = "source.zig";
            file-types = ["zig"];
            auto-format = true;
            formatter.command = "${pkgs.zls}/bin/zls";
          }
          # C
          {
            name = "c";
            scope = "source.c";
            file-types = ["c"];
            auto-format = true;
            formatter.command = "clang-format"; # Assuming clang is used for formatting
          }
          # C++
          {
            name = "cpp";
            scope = "source.cpp";
            file-types = ["cpp" "cc" "cxx"];
            auto-format = true;
            formatter.command = "clang-format"; # Assuming clang is used for formatting
          }
        ];
      };
      themes = {
        autumn_night_transparent = {
          "inherits" = "autumn_night";
          "ui.background" = {};
        };
      };
    };
  };
}
