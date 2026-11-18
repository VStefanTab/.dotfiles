-- Leader key
vim.g.mapleader = " "

-- LSP keybinds
-- gd - go to definition
-- gD - go to Declaration
-- grr - go to referece
-- K - hover documentation (Awesome)
-- gri - go to implementation
-- gra - code actions

-- gc : Comment line

-- Change word everywhere locally
-- :%s/search_word/replace_word/g
-- :%s/search_word/replace_word/gc -> this is for confirmation

-- Terminal Open (TODO: doesn't work)
-- vim.keymap.set("n", ":terminal", "tt", {noremap = true, silent = true})

-- Terminal Exit (TODO: doesn't work)
-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Moving half screen down/up
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Move selected code up and down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Moving line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Moving line up" })
vim.keymap.set(
	"v",
	"<A-j>",
	":m '>+1<CR>gv=gv",
	{ desc = "Move selection down" }
)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Opening Diagnostic Window
vim.keymap.set(
	"n",
	"<Esc>f",
	":lua vim.diagnostic.setqflist()<CR>",
	{ noremap = true, silent = true }
)

-- SplitScreen keys
vim.keymap.set(
	"n",
	"<Leader>-",
	":split<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<Leader>|",
	":vsplit<CR>",
	{ noremap = true, silent = true }
)

-- Navigate between splits
vim.keymap.set(
	"n",
	"<Leader>h",
	":wincmd h<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<Leader>l",
	":wincmd l<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<Leader>j",
	":wincmd j<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<Leader>k",
	":wincmd k<CR>",
	{ noremap = true, silent = true }
)

-- Resizing split screens equally
vim.o.equalalways = true
vim.keymap.set("n", "<Leader>=", "<C-w>=", { noremap = true, silent = true }) -- Equalize

-- Resize the current split window
vim.keymap.set(
	"n",
	"<Leader><Up>",
	":resize +6<CR>",
	{ noremap = true, silent = true }
) -- Increase height
vim.keymap.set(
	"n",
	"<Leader><Down>",
	":resize -6<CR>",
	{ noremap = true, silent = true }
) -- Decrease height
vim.keymap.set(
	"n",
	"<Leader><Left>",
	":vertical resize -6<CR>",
	{ noremap = true, silent = true }
) -- Decrease width
vim.keymap.set(
	"n",
	"<Leader><Right>",
	":vertical resize +6<CR>",
	{ noremap = true, silent = true }
) -- Increase width

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

vim.keymap.set(
	"n",
	"<Leader>z",
	ToggleFullscreen,
	{ noremap = true, silent = true }
) -- Maximize fullscreen

-- Close all other windows except the current one
vim.keymap.set(
	"n",
	"<Leader>a",
	":wincmd o<CR>",
	{ noremap = true, silent = true }
)

-- Keybinds for edit config
vim.keymap.set("n", "<leader>ev", function()
    vim.cmd("edit $MYVIMRC")end, {desc= "Edit nvim config"}
)

-- TODO: Make a keybind to close the current one and leave the others

-- TODO: Make keybinds for tabs
-- gt - Goes to the next tab
-- gT - Goes to the previous tab
-- {n}gt - Goes to the {n} tab
-- shortcuts to be made:
-- 1. create new tab
-- 2. close current tab
-- 3. close other tabs

-- TODO: Make keybind for copen

--vim.keymap.set("n", "<leader>p", '"0p', {noremap = true, silent = true})
