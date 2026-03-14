-- Leader key
vim.g.mapleader = " "

-- LSP keybinds
-- gd - go to definition
-- gD - go to Declaration
-- gr - go to referece (TODO: need to fix because it is replacing)
-- K - hover documentation (Awesome)
-- gi - go to implementation
-- <leader>ca - code actions(TODO:Need to work on it)

-- gc : Comment line

-- Change word everywhere locally
-- :%s/search_word/replace_word/g
-- :%s/search_word/replace_word/gc -> this is for confirmation

-- Terminal Exit
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Moving half screen down/up
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Opening Diagnostic Window
vim.keymap.set("n", "<Esc>f", ":lua vim.diagnostic.setqflist()<CR>", { noremap = true, silent = true })

-- SplitScreen keys
vim.keymap.set("n", "<Leader>-", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>|", ":vsplit<CR>", { noremap = true, silent = true })

-- Navigate between splits
vim.keymap.set("n", "<Leader>h", ":wincmd h<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>l", ":wincmd l<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>j", ":wincmd j<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>k", ":wincmd k<CR>", { noremap = true, silent = true })

-- Resizing split screens equally
vim.o.equalalways = true
vim.keymap.set("n", "<Leader>=", "<C-w>=", { noremap = true, silent = true }) -- Equalize

-- Resize the current split window
vim.keymap.set("n", "<Leader><Up>", ":resize +6<CR>", { noremap = true, silent = true }) -- Increase height
vim.keymap.set("n", "<Leader><Down>", ":resize -6<CR>", { noremap = true, silent = true }) -- Decrease height
vim.keymap.set("n", "<Leader><Left>", ":vertical resize -6<CR>", { noremap = true, silent = true }) -- Decrease width
vim.keymap.set("n", "<Leader><Right>", ":vertical resize +6<CR>", { noremap = true, silent = true }) -- Increase width

-- Maximizing focused screen
local is_maximized = false

function ToggleFullscreen()
	if is_maximized then
		vim.cmd("wincmd =") -- Restore original layout
		is_maximized = false
	else
		vim.cmd("wincmd |") -- Maximize width
		vim.cmd("wincmd _") -- Maximize height
		is_maximized = true
	end
end

vim.keymap.set("n", "<Leader>z", ToggleFullscreen, { noremap = true, silent = true }) -- Maximize fullscreen

-- Close all other windows except the current one
vim.keymap.set("n", "<Leader>a", ":wincmd o<CR>", { noremap = true, silent = true })

-- TODO: Make a keybind to close the current one and leave the others

-- TODO: Make keybinds for tabs

-- TODO: Make keybind for copen

--vim.keymap.set("n", "<leader>p", '"0p', {noremap = true, silent = true})
