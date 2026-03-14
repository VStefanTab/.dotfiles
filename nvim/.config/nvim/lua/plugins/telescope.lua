return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},

		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						".git/.*",
						"node_modules/.*",
						"lazy-lock.json",
						"yarn.lock",
					}, -- Ignore .git directory
					preview = {
						treesitter = false,
					},
				},
				pickers = {
					find_files = {
						hidden = true, -- Show hidden files
						no_ignore = true,
					},
				},
			})
			local builtin = require("telescope.builtin")
			-- <C-x> : Go to file selection as a split
			-- <C-v> : Go to file selection as a vsplit
			-- <C-t> : Go to a file in a new tab
			-- <C-u> : Scroll up in preview window
			-- <C-d> : Scroll down in preview window
			-- <C-c> : Close telescope(insert mode)
			-- <Esc> : Close telescope (in normal mode)
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fc", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
			vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>fr", builtin.registers, {})
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>fe", function ()
			    local ext = vim.fn.input("Extension: ")
                require("telescope.builtin").find_files({
                    find_command = {"rg", "--files", "--hidden", "--glob", "*." .. ext},
                })
			end, {desc = "Find files by extensions"})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			telescope.load_extension("ui-select")
			telescope.load_extension("live_grep_args")
		end,
	},
}
