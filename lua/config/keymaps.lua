-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
