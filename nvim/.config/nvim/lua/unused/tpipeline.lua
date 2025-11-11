return {
  "vimpostor/vim-tpipeline",
  config = function()
    -- Center the statusline relative to the window (better for tmux)
    vim.g.tpipeline_status_justify = "relative-centre"

    -- Sections to display in the statusline
    vim.g.tpipeline_sections = { "mode", "branch", "filename", "position" }
  end
}
