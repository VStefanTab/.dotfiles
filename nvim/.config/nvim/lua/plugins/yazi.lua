---@type LazySpec
return {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
        {
            "<leader>-",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
        {
            "<leader>cw",
            "<cmd>Yazi cwd<cr>",
            desc = "Open the file manager in nvim's working directory",
        },
        {
            "<c-up>",
            "<cmd>Yazi toggle<cr>",
            desc = "Resume the last yazi session",
        },
    },
    opts = {
        keymaps = {
            show_help = "<f1>",
        },
        open_in_current_window = true,
        use_yazi_client = true,
        send_path_on_exit = true,
        set_cwd_on_exit = true,

        open_for_directories = false,

        -- Change Neovim's cwd to the chosen directory (or the file's directory)
        -- and then open the selection.
        open_file_function = function(chosen_path, config, state)
            local uv = vim.loop
            local stat = uv.fs_stat(chosen_path)
            if stat and stat.type == "directory" then
                vim.cmd("cd " .. vim.fn.fnameescape(chosen_path))
                -- optional: open that dir as a buffer if you like:
                -- vim.cmd("edit .")
                return
            end
            -- It's a file: cd to its directory, then open it
            local dir = vim.fn.fnamemodify(chosen_path, ":h")
            vim.cmd("cd " .. vim.fn.fnameescape(dir))
            vim.cmd("edit " .. vim.fn.fnameescape(chosen_path))
        end,
    },
    init = function()
        vim.g.loaded_netrwPlugin = 1
    end,
}
