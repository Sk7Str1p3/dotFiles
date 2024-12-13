{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    clipboard.providers.wl-copy.enable = true;
    extraConfigLua = ''
      vim.opt.number = true
    '';
    colorschemes.catppuccin.enable = true;
    plugins = {
      cmp = {
        enable = true;
        cmdline = {
          "/" = {
            mapping.__raw = ''
              cmp.mapping.preset.cmdline()
            '';
            sources = [
              {
                name = "buffer";
              }
            ];
          };
          "?" = {
            mapping.__raw = ''
              cmp.mapping.preset.cmdline()
            '';
            sources = [
              {
                name = "buffer";
              }
            ];
          };
          ":" = {
            mapping.__raw = ''
              cmp.mapping.preset.cmdline()
            '';
            sources = [
              {
                name = "path";
              }
              {
                name = "cmdline";
              }
            ];
          };
        };
        settings = {
          window = {
            completion = {
              __raw = ''
                cmp.config.window.bordered()
              '';
            };
            documentation = {
              __raw = ''
                cmp.config.window.bordered()
              '';
            };
          };
          snippet = {
            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          };
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            {
              name = "nvim_lsp";
            }
            {
              name = "luasnip";
            }
            {
              name = "buffer";
            }
          ];
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      cmp-nvim-lua.enable = true;
      luasnip.enable = true;
      lsp-lines.enable = true;
      lsp-format.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          typos_lsp.enable = true;
          lua_ls.enable = true;
          pyright.enable = true;
          nixd = {
            enable = true;
            extraOptions.offset_encoding = "utf-8";
            settings.formatting.command = [
              "nixfmt"
            ];
          };
          clangd.enable = true;
        };
      };

      autoclose.enable = true;
      startup = {
        enable = true;
        sections = {
          header = {
            type = "text";
            oldfilesDirectory = false;
            align = "center";
            foldSection = false;
            title = "Header";
            margin = 1;
            content = [
              " ⠀⠀⠀⠀⠀⢀⡤⠾⣤⡴⠚⣻⣿⣛⣲⣾⣟⢲⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⢀⡏⠀⠀⠈⠀⣾⠛⣭⠉⣧⡘⠏⣇⣳⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⡸⠀⠀⠀⠈⡆⠘⢤⡽⠾⠃⠈⠉⠉⠉⠀⠀⠀⠉⠉⠙⠢⣄⠀⠀⠀"
              "⠀⠀⠀⠀⢧⠀⠀⠀⢀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣦⡀⠀"
              "⠀⠀⠀⠀⠈⡟⠒⠒⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⡄"
              "⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⡇"
              "⠀⠀⠀⠀⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⡿⠁"
              "⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⠟⠁⠀"
              "⠀⠀⠀⠀⠀⢻⡀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⡤⠴⠊⠁⠀⠀⠀"
              "⠀⠀⠀⠀⠀⢿⡈⠓⠤⣀⠀⠀⠀⠀⠻⠿⠟⢋⠀⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⣠⠋⠙⠢⣄⡀⠈⠉⠚⠛⠒⠒⠊⣁⠤⢾⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⣰⠃⠀⠀⠀⠀⠈⠉⠓⠒⠒⠒⠈⣹⢇⠀⠈⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⢰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⡤⠇⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⢸⡀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠈⣧⠀⠀⠀⠀⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⢰⡏⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⢹⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⢸⠁⢰⠂⢠⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣇⡼⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠈⢻⠯⠔⠻⠤⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⢀⡸⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠐⢶⣋⣀⡤⢷⠀⠀⠀⠀⠀⠀⠀⠐⡆⠀⠀⠀⠀⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠀⠀⠀⠀⢹⡄⠀⠀⠀⠀⠈⡇⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⣼⠁⠀⠀⠀⠀⠐⠧⡀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⡙⣆⠀⠀⠀⢀⠀⣌⡇⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠹⣄⠀⠀⠀⠀⠀⠀⠲⡀⠱⣼⠀⠀⠀⠀⣧⡼⠃⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠈⠙⠒⠤⢤⣀⣀⣀⡵⠴⠋⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            ];
            highlight = "Keyword";
            defaultColor = "";
            oldfilesAmount = 0;
          };
          body = {
            type = "mapping";
            oldfilesDirectory = false;
            align = "center";
            foldSection = false;
            title = "Menu";
            margin = 1;
            content = [
              [
                " New file"
                "ene"
                "n"
              ]
              [
                "󰈆 Quit"
                "wqa!"
                "qq"
              ]
              [
                "󱝩 Search file"
                "Telescope find_files"
                "ff"
              ]
              [
                "󰺄 Search word"
                "Telescope live_grep"
                "fw"
              ]
              [
                " Recent"
                "Telescope oldfiles"
                "fr"
              ]
              [
                " Edit Home"
                "e /etc/nixos/home-Sk7Str1p3.nix"
                "ec"
              ]
            ];
            highlight = "Type";
            defaultColor = "";
            oldfilesAmount = 0;
          };
          quote = {
            type = "text";
            oldfilesDirectory = false;
            align = "center";
            foldSection = false;
            title = "Quote";
            margin = 0;
            content = [
              "TUI supremacy"
            ];
            highlight = "Statement";
            defaultColor = "";
            oldfilesAmount = 0;
          };
        };
        options = {
          paddings = [
            1
            1
            1
          ];
        };
        parts = [
          "header"
          "body"
          "quote"
        ];
      };
      notify.enable = true;
      noice = {
        enable = true;
        settings = {
          lsp.override = {
            "vim.lsp.util.convert_input_to_markdown" = true;
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
          cmdline = {
            enabled = true;
            view = "cmdline_popup";
            opts = {};
            format = {
              cmdline = {
                icon = "";
                lang = "vim";
                pattern = "^:";
              };
              filter = {
                icon = "$";
                lang = "bash";
                pattern = "^:%s*!";
              };
              help = {
                icon = "?";
                pattern = "^:%s*he?l?p?%s+";
              };
              input = {};
              lua = {
                icon = "";
                lang = "lua";
                pattern = "^:%s*lua%s+";
              };
              search_down = {
                icon = " ";
                kind = "search";
                lang = "regex";
                pattern = "^/";
              };
            };
          };
          messages = {
            enabled = true;
            view = "notify";
            viewError = "notify";
            viewWarn = "notify";
            viewHistory = "messages";
            viewSearch = "virtualtext";
          };
          popupmenu = {
            enabled = true;
            backend = "nui";
            kindIcons = {};
          };
        };
      };
      web-devicons.enable = true;
      lualine = {
        enable = true;
      };
    };
  };
}
