vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader><leader>", vim.cmd.w)
vim.keymap.set("n", "<leader><leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader><leader>q", vim.cmd.wq)
vim.api.nvim_set_keymap('n', '<leader>ca', 'ggVG"+y', { noremap = true, silent = true })

-- vim.keymap.set("n", "<leader><leader>t", vim.cmd.terminal)
-- vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('t', '<leader><leader>b', '<C-\\><C-n>:b#<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader><leader>b', '<C-\\><C-n>:b#<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader><leader>r', function()
  package.loaded['semicolonify'] = nil
  require('semicolonify')
  print('Plugin reloaded!')
end)

vim.keymap.set("n", "<leader><leader>;", function()
    require("semicolonify").semicolonify()
end)


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)


-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- the best go command EVER - Jamie
vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)
vim.keymap.set(
    "n",
    "<leader>ep",
    "oif err != nil {<CR>}<Esc>Olog.Fatal(err)<Esc>"
)

vim.keymap.set('n', '<leader>wr', function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle Wrap" })


vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
