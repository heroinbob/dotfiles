-- Options
local o = vim.opt
o.number = true            -- line numbers
o.relativenumber = true    -- relative line numbers
o.tabstop = 2              -- tab width
o.shiftwidth = 2           -- indent width
o.expandtab = true         -- spaces instead of tabs
o.smartindent = true       -- auto-indent new lines
o.wrap = false             -- no line wrapping
o.ignorecase = true        -- case-insensitive search...
o.smartcase = true         -- ...unless uppercase is used
o.hlsearch = false         -- don't persist search highlights
o.incsearch = true         -- incremental search
o.termguicolors = true     -- 24-bit color
o.scrolloff = 8            -- keep 8 lines above/below cursor
o.signcolumn = "yes"       -- always show sign column
o.updatetime = 250         -- faster CursorHold events
o.clipboard = "unnamedplus" -- use system clipboard
o.undofile = true          -- persistent undo

vim.cmd.filetype("plugin indent on")
