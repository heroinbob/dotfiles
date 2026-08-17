-- local HOME = vim.fn.expand("~")
-- local local_dev = "file://" .. HOME

vim.pack.add({
    -- Use version 4.x for stability; omit to use `main` branch for the latest features
    { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("4.x") },
    {
      src = "https://github.com/nvim-neotest/neotest",
      version = vim.version.range("5.x")
    },
    -- ====================
    -- Neotest dependencies
    -- ====================
    -- Library for asynchronous IO in neovim.
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    -- Neotest adapter for Elixir
    { src = "https://github.com/jfpedroza/neotest-elixir" },
    -- Neotest adapter for plenary.nvim busted tests
    { src = "https://github.com/nvim-neotest/neotest-plenary" },
    -- Library for NeoVim utility. "Functions I don't wanna write twice"
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    -- plugin to fix CursorHold performance
    -- NOTE: The repo says this is not needed after a neovim commit from 2022
    -- { src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
    -- ================
    -- END Neotest deps
    -- ================
    { src = "https://github.com/mason-org/mason.nvim" },
    -- { src = "https://github.com/mcauley-penney/techbase.nvim" },
    -- { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    -- { src = local_dev .. "/personal/techbase.nvim", version = "fix/core-hl-groups" },
    { src = "https://github.com/vieitesss/miniharp.nvim" },
    -- { src = "https://github.com/vieitesss/gh-permalink.nvim" },
    -- { src = local_dev .. "/personal/miniharp.nvim", version = "fix/do-not-save-index" },
    -- { src = "https://github.com/ThePrimeagen/harpoon",        version = "harpoon2" },
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("^1"),
    },
    { src = "https://github.com/vieitesss/command.nvim", version = "main" },
    -- { src = "https://github.com/vieitesss/command.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/github/copilot.vim" },
    -- { src = "https://github.com/lervag/vimtex" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/RRethy/base16-nvim" },
    { src = "https://github.com/akinsho/bufferline.nvim" },
    { src = "https://github.com/smoka7/hop.nvim", version = vim.version.range("2.x") },
    { src = "https://github.com/cappyzawa/trim.nvim" },
    { src = "https://github.com/numtostr/comment.nvim" },
})

vim.g.umbraline = { theme = "cursor" }

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

require("mini.icons").setup({})

-- HAAACK
require("nvim-treesitter").setup({})
require("nvim-treesitter").install({ "elixir", "heex", "eex" })

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

require("command").setup({})
require("miniharp").setup({ show_on_autoload = true })
require("mason").setup({})
-- require('techbase').setup({})
-- require('gruber-darker').setup({
--     bold = false,
--     italic = {
--         strings = false,
--     },
-- })
require("gitsigns").setup({ signcolumn = false })
require("blink.cmp").setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
    keymap = {
        preset = "default",
        ["<C-space>"] = {},
        ["<C-p>"] = {},
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-n>"] = { "select_and_accept" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_down", "fallback" },
        ["<C-f>"] = { "scroll_documentation_up", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        -- ["<C-e>"] = { "hide" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
    },

    cmdline = {
        keymap = {
            preset = "inherit",
            ["<CR>"] = { "accept_and_enter", "fallback" },
        },
    },

    sources = { default = { "lsp" } },
})

local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
    winopts = {
        height = 1,
        width = 1,
        backdrop = 85,
        preview = {
            horizontal = "right:70%",
        },
    },
    keymap = {
        builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<C-p>"] = "toggle-preview",
        },
        fzf = {
            ["ctrl-a"] = "toggle-all",
            ["ctrl-t"] = "first",
            ["ctrl-g"] = "last",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
        },
    },
    actions = {
        files = {
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-n"] = actions.toggle_ignore,
            ["ctrl-h"] = actions.toggle_hidden,
            ["enter"] = actions.file_edit_or_qf,
        },
    },
})

require("oil").setup({
    default_file_explorer = true,
    columns = {
        "permissions",
        "size",
    },
    constrain_cursor = "name",
    watch_for_changes = true,
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    view_options = {
        show_hidden = true,
    },
})

require("neotest").setup({
  event = { "BufReadPost", "BufNewFile" },
  adapters = {
    -- https://github.com/jfpedroza/neotest-elixir
    -- test adapter for elixir
    require ("neotest-elixir"),
    require ("neotest-plenary"),
    -- neotest-vim-test allows you to run tests when no adapter exists (like neotest-elixir)
    -- require "neotest-vim-test",
  },
  --log_level = vim.log.levels.DEBUG,
})

-- Required for bufferline to work. See documentation.
vim.opt.termguicolors = true
require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp"
  }
})

require("hop").setup({})
require("trim").setup({})
require("Comment").setup({})
