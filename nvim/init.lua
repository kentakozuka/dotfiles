local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')
Plug('catppuccin/nvim')
Plug('preservim/nerdtree')
Plug('neoclide/coc.nvim')
Plug('ryanoasis/vim-devicons')
Plug('sindrets/diffview.nvim')
Plug('jesseduffield/lazygit')

vim.call('plug#end')

vim.opt.winborder = 'rounded'

-- Color schemes should be loaded after plug#end().
vim.cmd('silent! colorscheme catppuccin')

-- expandtab オプションを設定します。タブ文字をスペースに変換します。
vim.cmd("set expandtab")

-- tabstop オプションを設定します。タブ文字の幅を4スペースに設定します。
vim.cmd("set tabstop=4")

-- softtabstop オプションを設定します。インサートモードでのタブの幅を4スペースに設定します。
vim.cmd("set softtabstop=4")

-- shiftwidth オプションを設定します。インデントに使用するスペースの幅を4スペースに設定します。
vim.cmd("set shiftwidth=4")

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<C-t>', ':NERDTreeToggle<CR>', opts)

vim.g.NERDTreeShowHidden = 1

require('lsp')
