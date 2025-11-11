local function close_neo_tree()
	-- Close neo-tree if it's open
	vim.cmd("Neotree close")
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				width = 30,
				auto_expand_width = false,
			},
		})

    -- Auto-quit when Neo-tree is the last window
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        if vim.fn.winnr("$") == 1 and vim.bo.filetype == "neo-tree" then
          vim.cmd("quit")
        end
      end,
    })
		-- Keymap to open Neo-tree
vim.keymap.set("n", "<C-t>", function()
  -- If the current buffer is Neo-tree
  if vim.bo.filetype == "neo-tree" then
    -- Jump back to the previously focused window
    vim.cmd("wincmd p")
  else
    -- Otherwise, open Neo-tree
    vim.cmd("Neotree filesystem reveal left")
  end
end, { desc = "Toggle Neo-tree / return to editor" })

		-- Keymap to close Neo-tree
		vim.keymap.set("n", "<Esc>t", close_neo_tree, {})
	end,
}
