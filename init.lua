-- Set <leader> key to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Load Plugins
require('config.utils')
require('config.lazy')

require('config.settings')
require('config.events')
require('config.mappings')

require('lsp')

vim.cmd.colorscheme('catppuccin-mocha')
