vim.g.mapleader = ","

require 'plugins'
require 'configs'
require 'lsp'
require 'keymaps'
require 'statusline'
require 'umbraline'

vim.cmd('colorscheme base16-ashes')

vim.api.nvim_create_autocmd("BufWritePre", {
  command = "lua vim.lsp.buf.format()",
  pattern = { "*.ex", "*.exs", "*.heex", "*.eex" },
})
