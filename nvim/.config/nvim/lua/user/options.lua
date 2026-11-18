vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- Enable line numbers and relative numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Yank to Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Disable hererocks
--opts.rocks.hererocks = false

-- Limit stuff to 80 chars
vim.opt.colorcolumn = "80" -- Visual guide at 80 characters
vim.opt.textwidth = 80 -- Auto-wrap text at 80 characters while typing
vim.cmd("set formatoptions+=t") -- Ensure automatic wrapping while typing

-- Enable Treesitter folding
-- Keybinds(already defined)
-- za toggle a fold at the cursor.
-- zo opens a fold at the cursor.
-- zO opens all folds at the cursor.
-- zc closes a fold under cursor.
-- zm increases the foldlevel by one.
-- zM closes all open folds.
-- zr decreases the foldlevel by one.
-- zR decreases the foldlevel to zero
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- Optional: Set fold level (how deeply the folds should be open by default)
vim.o.foldlevel = 99

-- Wait less for terminal key codes
vim.opt.ttimeoutlen = 0

-- Behaviour settings
vim.opt.errorbells = false
vim.opt.encoding = "UTF-8"
vim.opt.backspace = "indent,eol,start"

-- File handling
vim.opt.updatetime = 300
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autowrite = false
vim.opt.autoread = true
