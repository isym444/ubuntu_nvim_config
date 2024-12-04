-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("oil").setup({
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "oil://*",
    callback = function()
      vim.cmd("cd " .. require("oil").get_current_dir())
    end,
  }),
})
