-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("oil").setup({
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "oil://*",
    callback = function()
      vim.cmd("cd " .. require("oil").get_current_dir())
    end,
  }),

  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
  },
  win_options = {
    wrap = true,
  },
})
