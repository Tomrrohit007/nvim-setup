return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "cssls",
        "ts_ls",
        "dockerls",
        "emmet_ls",
        "jsonls",
        "lua_ls", "prismals",
        "tailwindcss",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      local servers = {
        ts_ls = {},
        cssls = {},
        dockerls = {},
        emmet_ls = {},
        jsonls = {},
        lua_ls = {},
        prismals = {},
        tailwindcss = {},
      }
      for server, opts in pairs(servers) do
        lspconfig[server].setup(vim.tbl_extend("force", {
          capabilities = capabilities,
          on_attach = on_attach,
        }, opts))
      end
    end,
  },
}
