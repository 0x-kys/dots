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
            auto-format = true;
            formatter = {
              command = "${pkgs.alejandra}/bin/alejandra";
            };
            language-servers = ["nil"];
          }

          # Rust
          {
            name = "rust";
            auto-format = true;
            formatter = {
              command = "${pkgs.rustfmt}/bin/rustfmt";
            };
            language-servers = ["rust-analyzer"];
          }

          # HTML
          {
            name = "html";
            auto-format = true;
            formatter = {
              command = "${pkgs.prettierd}/bin/prettierd";
              args = ["html"];
            };
            language-servers = ["html-languageserver"];
          }

          # CSS
          {
            name = "css";
            auto-format = true;
            formatter = {
              command = "${pkgs.prettierd}/bin/prettierd";
              args = ["css"];
            };
            language-servers = ["css-languageserver"];
          }

          # JavaScript
          {
            name = "javascript";
            auto-format = true;
            formatter = {
              command = "${pkgs.prettierd}/bin/prettierd";
              args = ["javascript"];
            };
            language-servers = ["typescript-language-server"];
          }

          # TypeScript
          {
            name = "typescript";
            auto-format = true;
            formatter = {
              command = "${pkgs.prettierd}/bin/prettierd";
              args = ["typescript"];
            };
            language-servers = ["typescript-language-server"];
          }

          # Svelte
          {
            name = "svelte";
            auto-format = true;
            formatter = {
              command = "${pkgs.nodePackages.prettier}/bin/prettier";
              args = ["--parser" "svelte"];
            };
            language-servers = ["svelte-language-server"];
          }

          # Astro
          {
            name = "astro";
            auto-format = true;
            formatter = {
              command = "${pkgs.nodePackages.prettier}/bin/prettier";
              args = ["--parser" "astro"];
            };
            language-servers = ["astro-ls"];
          }

          # JSX
          {
            name = "jsx";
            auto-format = true;
            formatter = {
              command = "${pkgs.prettierd}/bin/prettierd";
              args = ["jsx"];
            };
            language-servers = ["typescript-language-server"];
          }

          # TSX
          {
            name = "tsx";
            auto-format = true;
            formatter = {
              command = "${pkgs.prettierd}/bin/prettierd";
              args = ["tsx"];
            };
            language-servers = ["typescript-language-server"];
          }

          # Zig
          {
            name = "zig";
            auto-format = true;
            formatter = {
              command = "${pkgs.zls}/bin/zls";
              args = ["--format"];
            };
            language-servers = ["zls"];
          }

          # Go
          {
            name = "go";
            auto-format = true;
            formatter = {
              command = "${pkgs.gofumpt}/bin/gofumpt";
            };
            language-servers = ["gopls"];
          }
        ];
        language-server = {
          nil = {
            command = "${pkgs.nil}/bin/nil";
          };
          rust-analyzer = {
            command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          };
          "html-languageserver" = {
            command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
            args = ["--stdio"];
          };
          "css-languageserver" = {
            command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
            args = ["--stdio"];
          };
          "typescript-language-server" = {
            command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
            args = ["--stdio"];
          };
          "svelte-language-server" = {
            command = "${pkgs.nodePackages.svelte-language-server}/bin/svelteserver";
            args = ["--stdio"];
          };
          "astro-ls" = {
            command = "${pkgs.astro-language-server}/bin/astro-ls";
            args = ["--stdio"];
          };
          zls = {
            command = "${pkgs.zls}/bin/zls";
          };
          gopls = {
            command = "${pkgs.gopls}/bin/gopls";
            args = ["serve"];
          };
        };
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
