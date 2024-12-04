-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- Map 'jj' to <Esc> in insert mode
vim.api.nvim_set_keymap("i", "jj", "<Esc>", opts)

-- Navigate buffers
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

-- Close buffer
vim.keymap.set("n", "<Leader>q", ":bd<CR>", { desc = "Close current buffer" })

-- Jump to specific buffers by their position
for i = 1, 9 do
  vim.keymap.set("n", "<Leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Go to buffer " .. i })
end

-- Map <Leader>h to execute :Alpha
vim.keymap.set("n", "<Leader>h", ":Alpha<CR>", { desc = "Open Alpha dashboard" })

vim.api.nvim_set_keymap("t", "jj", "<C-\\><C-n>", { noremap = true, silent = true })

-- Create a global table for custom functions if it doesn't already exist
_G.my_custom_functions = _G.my_custom_functions or {}

-- Store the terminal buffer ID
local terminal_buf = nil

-- Define the toggle_terminal function
function _G.my_custom_functions.toggle_terminal()
  -- Check the current mode
  local mode = vim.fn.mode()

  -- If in Terminal mode, switch to Normal mode first
  if mode == "t" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
  end

  -- Check if the terminal buffer exists and is valid
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    -- Check if the terminal is currently visible in any window
    local terminal_win = vim.fn.bufwinnr(terminal_buf)
    if terminal_win > 0 then
      -- Close the terminal window
      vim.api.nvim_win_close(vim.fn.win_getid(terminal_win), true)
    else
      -- Reopen the terminal in a vertical split and switch to Terminal mode
      vim.cmd("vsplit")
      vim.cmd("buffer " .. terminal_buf)
      vim.cmd("vertical resize 50") -- Adjust the width to 50 columns
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "n", true)
    end
  else
    -- Create a new terminal if it doesn't exist
    vim.cmd("vsplit")
    vim.cmd("terminal")
    terminal_buf = vim.api.nvim_get_current_buf() -- Store the terminal buffer ID
    vim.cmd("vertical resize 50") -- Adjust the width to 50 columns

    -- Enter Terminal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "n", true)
  end
end

-- Map Ctrl-` to toggle the terminal
vim.api.nvim_set_keymap(
  "n",
  "<C-`>",
  ":lua _G.my_custom_functions.toggle_terminal()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "t",
  "<C-`>",
  "<C-\\><C-n>:lua _G.my_custom_functions.toggle_terminal()<CR>",
  { noremap = true, silent = true }
)
