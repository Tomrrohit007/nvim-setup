return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter", -- or BufReadPre, BufNewFile
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = {
        "html", "javascript", "typescript", "tsx",
      },
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
    }
  end,
}
