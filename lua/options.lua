-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus'  -- use system clipboard
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a'                -- allow the mouse to be used in nvim

-- Tab
vim.opt.tabstop = 4                -- number of visual spaces per TAB
vim.opt.softtabstop = 4            -- number of spaces in tab when editing
vim.opt.shiftwidth = 4             -- insert 4 spaces on a tab
vim.opt.expandtab = true           -- tabs are spaces, mainly bacause of python

-- UI config
vim.opt.number = true              -- show absolute number
vim.opt.relativenumber = true
vim.opt.cursorline = true          -- highlight cursor line
vim.opt.splitbelow = true          -- open new vertical split bottom
vim.opt.splitright = true          -- open new horizontal split right
vim.opt.showmode = false

-- Searching
vim.opt.incsearch = true           -- search as characters are entered
vim.opt.hlsearch = false           -- do not highlight matches
vim.opt.ignorecase = true          -- ignore case in search by default
vim.opt.smartcase = true

