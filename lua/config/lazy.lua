local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- If opening from inside neovim terminal then do not load all the other plugins
if os.getenv('NVIM') ~= nil then
    require('lazy').setup({
        { 'willothy/flatten.nvim', config = true },
    })
    return
end

require('lazy').setup('config.plugins', {
    git = { timeout = 300 },
    -- dev = { path = '~/Documents/Programming/Repo' },
    diff = { cmd = 'terminal_git' },
    checker = { enabled = false },
    change_detection = {
        enabled = true,
        notify = false, -- get a notification when changes are found
    },
    performance = {
        cache = { enabled = true },
        rtp = {
            disabled_plugins = {
                'matchit',
                'matchparen',
                'netrwPlugin',
                'tarPlugin',
                'zipPlugin',
            },
        },
    },
})

vim.keymap.set('n', '<leader>mp', '<CMD>Lazy home<CR>', { desc = 'Manage plugin (with Lazy)', remap = false })
