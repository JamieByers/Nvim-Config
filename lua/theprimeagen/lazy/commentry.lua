return {
  {
    "tpope/vim-commentary",
    config = function()
      -- Remap 'gcc' to 'gc' for commenting in normal mode (as an example)
      vim.keymap.set("n", "<leader>c", "gcc", { noremap = true, silent = true })
      -- Optional: Remap for visual mode as well
      vim.keymap.set("v", "<leader>c", "gc", { noremap = true, silent = true })
    end
  },
}

