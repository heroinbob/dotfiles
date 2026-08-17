-- Keymaps
local map = vim.keymap.set

-- Window navigation
--map("n", "<C-h>", "<C-w>a")
--map("n", "<C-j>", "<C-w>o")
--map("n", "<C-k>", "<C-w>k")
--map("n", "<C-l>", "<C-w>l")
map("n", "<leader>e", "<C-w>h", { desc = "Window left" })
map("n", "<leader>u", "<C-w>l", { desc = "Window right" })
map("n", "<leader>o", "<C-w>j", { desc = "Window down" })
map("n", "<leader>a", "<C-w>k", { desc = "Window up" })

-- Move selected lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Quick save / quit
map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")
map("n", "<leader>qn", ":q!<CR>", { desc = "Quit, no save" })
map("n", "<leader>wq", ":wq<CR>", { desc = "Save & Quit" })

-- Clear search with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- cd current dir
map("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')

local ns = { noremap = true, silent = true }
local er = { expr = true, replace_keycodes = false }
map("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", ns)
map("n", "<leader>co", "<cmd>CommandExecute<CR>")
map("n", "<leader>cr", "<cmd>CommandExecuteLast<CR>")
map("n", "<leader>dn", "<cmd>lua vim.diagnostic.jump({count = 1})<CR>", ns)
map("n", "<leader>dp", "<cmd>lua vim.diagnostic.jump({count = -1})<CR>", ns)
map("n", "<leader>ex", "<cmd>Ex %:p:h<CR>")
map("n", "<leader>ff", "<cmd>FzfLua files<CR>")
map("n", "<leader>fg", "<cmd>FzfLua grep_project<CR>")
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>")
map("n", "<leader>fl", "<cmd>FzfLua grep_last<CR>")
map("n", "<leader>g", "<cmd>:HopWord<CR>")
map("n", "<leader>gp", "<cmd>Git push<CR>", ns)
map("n", "<leader>gs", "<cmd>Git<CR>", ns)
map("n", "<leader>oc", function() require("oil").open(vim.fn.getcwd()) end)
map("n", "<leader>of", "<cmd>Oil<CR>")
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")
map({"x", "v"}, "<leader>co", "<cmd>CommandExecuteSelection<CR>")
map("i", "<S-Tab>", 'copilot#Accept("\\<Tab>")', er)
map("n", "<leader>ma", require("miniharp").toggle_file)
map("n", "<leader>mc", require("miniharp").clear)
map("n", "<leader>l", require("miniharp").show_list)
map("n", "<C-n>", require("miniharp").next)
map("n", "<C-p>", require("miniharp").prev)
map("n", "<leader>t", "<cmd>bnext<CR>")
map("n", "<leader>tt", "<cmd>bprev<CR>")
map("n", "<leader>x", "<cmd>:bd<CR>")

map("n", "<leader>so", function()
    require("fzf-lua").files({
        actions = {
            ["default"] = function(selected)
                local file = selected[1]
                local rel_path = vim.fn.fnamemodify(file, ":.")

                rel_path = rel_path:gsub(" ", "\\ ")
                if not rel_path:match("^%.?/") then
                    rel_path = "./" .. rel_path
                end

                vim.api.nvim_put({ rel_path }, "l", true, false)
            end,
        },
    })
end)

-- Testing
map("n", "<leader>ts", ":lua require('neotest').run.run()<CR>", { desc = "Run nearest test" })
map("n", "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "Test file" })
map("n", "<leader>ta", ":lua require('neotest').run.run({ suite = true })<CR>", { desc = "Test suite" })
map("n", "<leader>to", ":lua require('neotest').output_panel.toggle()<CR>", { desc = "Toggle test output" })
map("n", "<leader>tu", ":lua require('neotest').summary.toggle()<CR>", { desc = "Toggle summary" })
