return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-telescope/telescope-ui-select.nvim",
        },

        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    file_ignore_patterns = {
                        ".git/.*",
                        "node_modules/.*",
                        "lazy-lock.json",
                        "yarn.lock",
                        ".*env/",
                    },

                    preview = {
                        treesitter = false,
                    },

                    mappings = {
                        i = {
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,
                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,
                            ["<C-c>"] = actions.close,
                        },
                    },
                },

                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                    },
                },

                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                    live_grep_args = {
                        auto_quoting = true,
                    },
                },
            })

            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
            telescope.load_extension("live_grep_args")

            -- General pickers
            vim.keymap.set("n", "<C-p>", builtin.find_files,
                { desc = "Find files" })

            vim.keymap.set("n", "<leader>fc", builtin.live_grep,
                { desc = "Live grep" })

            vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols,
                { desc = "Document symbols" })

            vim.keymap.set("n", "<leader>fw", builtin.grep_string,
                { desc = "Search word under cursor" })

            vim.keymap.set("n", "<leader>fg", builtin.git_files,
                { desc = "Git files" })

            vim.keymap.set("n", "<leader>fo", builtin.oldfiles,
                { desc = "Recent files" })

            vim.keymap.set("n", "<leader>fr", builtin.registers,
                { desc = "Registers" })

            vim.keymap.set("n", "<leader>fk", builtin.keymaps,
                { desc = "Keymaps" })

            vim.keymap.set("n", "<leader>fl", builtin.diagnostics,
                { desc = "Diagnostics" })

            vim.keymap.set("n", "<leader>ff", builtin.lsp_references,
                { desc = "LSP references" })

            vim.keymap.set("n", "<leader>fa", function()
                require("telescope").extensions.live_grep_args.live_grep_args()
            end, { desc = "Live grep with arguments" })

            vim.keymap.set("n", "<leader>fe", function()
                local ext = vim.fn.input("Extension: ")

                if ext == "" then
                    return
                end

                builtin.find_files({
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--glob",
                        "!**/.git/*",
                        "--glob",
                        "*." .. ext,
                    },
                })
            end, { desc = "Find files by extension" })
        end,
    },
}
