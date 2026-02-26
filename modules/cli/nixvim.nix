{ ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    opts = {
      relativenumber = true;
      number = true;
      signcolumn = "yes";
      cursorline = false;
      wrap = true;
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      list = true;
      clipboard = "unnamedplus";
      spell = true;
      spelllang = [
        "pl"
        "en"
      ];
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<Space>";
        action = "<Nop>";
        options.silent = true;
      }
      {
        mode = "x";
        key = ">";
        action = ">gv";
        options.desc = "Shift code right";
      }
      {
        mode = "x";
        key = "<";
        action = "<gv";
        options.desc = "Shift code left";
      }

      {
        mode = "n";
        key = "<leader>a";
        action.__raw = "function() require('harpoon'):list():add() end";
        options.desc = "Add file to harpoon";
      }
      {
        mode = "n";
        key = "<C-e>";
        action.__raw = "function() require('telescope').extensions.harpoon.marks(require('telescope.themes').get_dropdown{}) end";
        options.desc = "Open harpoon window";
      }
      {
        mode = "n";
        key = "<C-h>";
        action.__raw = "function() require('harpoon'):list():select(1) end";
      }
      {
        mode = "n";
        key = "<C-j>";
        action.__raw = "function() require('harpoon'):list():select(2) end";
      }
      {
        mode = "n";
        key = "<C-k>";
        action.__raw = "function() require('harpoon'):list():select(3) end";
      }
      {
        mode = "n";
        key = "<C-l>";
        action.__raw = "function() require('harpoon'):list():select(4) end";
      }
      {
        mode = "n";
        key = "<C-S-P>";
        action.__raw = "function() require('harpoon'):list():prev() end";
        options.desc = "Toggle previous harpoon buffer";
      }
      {
        mode = "n";
        key = "<C-S-N>";
        action.__raw = "function() require('harpoon'):list():next() end";
        options.desc = "Toggle next harpoon buffer";
      }
    ];

    autoGroups = {
      YankHighlight = {
        clear = true;
      };
    };
    autoCmd = [
      {
        event = "TextYankPost";
        group = "YankHighlight";
        callback.__raw = ''
          function()
            vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
          end
        '';
      }
    ];

    plugins = {
      nvim-autopairs.enable = true;
      web-devicons.enable = true;

      which-key = {
        enable = true;
        settings.spec = [
          {
            __unkeyed-1 = "<leader>?";
            mode = "n";
            desc = "Buffer Local Keymaps (which-key)";
          }
        ];
      };

      gitsigns = {
        enable = true;
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options.desc = "Telescope find files";
          };
          "<leader>fg" = {
            action = "git_files";
            options.desc = "Telescope find git files";
          };
        };
      };

      harpoon = {
        enable = true;
        enableTelescope = true;
      };

      lsp = {
        enable = true;
        servers = {
          # script
          lua_ls.enable = true;
          # web
          cssls.enable = true;
          html.enable = true;
          emmet_ls.enable = true;
          friendly-snippets.enable = true;
          # dev
          clangd.enable = true;
          pyright.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          # nix
          nil_ls.enable = true;
          # other
          marksman.enable = true;
        };
        keymaps = {
          lspBuf = {
            "gd" = "definition";
            "gi" = "implementation";
            "<leader>ca" = "code_action";
            "<leader>cf" = "format";
            "<leader>r" = "rename";
          };
        };
      };

      lsp-format.enable = true;

      luasnip.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = false;
        };
      };

      indent-blankline = {
        enable = true;
        settings.scope.enabled = true;
      };

      cmp = {
        enable = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-y>" = "cmp.mapping.confirm({ select = true })";
            "<C-e>" = "cmp.mapping.abort()";
          };
          window = {
            documentation = {
              border = "rounded";
            };
          };
        };
      };
    };

    extraConfigLua = ''
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 2,
          source = "if_many",
        }
      });
    '';
  };
}
