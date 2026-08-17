--@type vim.lsp.Config
return { 
  cmd = { 'expert', '--stdio' },
  --filetypes = { 'exs', 'ex', 'heex', 'eex' },
  filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
  root_markers = { 'mix.exs' },
}
