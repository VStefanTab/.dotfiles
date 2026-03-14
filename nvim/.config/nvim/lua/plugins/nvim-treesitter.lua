return {
	"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        require("nvim-treesitter").setup({
		ensure_installed = {
			"c",
			"cpp",
			"java",
			"lua",
			"python",
			"bash",
			"llvm",
			"asm",
			"zig",
			"go",
		},
		auto_install = true,
		highlight = { enable = true, additional_vim_regex_highlighting = false },
		indent = { enable = true },
        })
    end,
}
