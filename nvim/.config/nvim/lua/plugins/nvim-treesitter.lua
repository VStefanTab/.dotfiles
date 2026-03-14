return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "c", "cpp", "java", "lua", "python", "bash", "llvm", "asm", "zig", "go", "c#" },
    auto_install = true,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
  },
}
