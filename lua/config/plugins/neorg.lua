return {
    'nvim-neorg/neorg',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' },
    build = ':Neorg sync-parsers',
    ft = 'norg',
    cmd = "Neorg",
    keys = {
        { '<Leader>nn', ':Neorg workspace ', desc = 'workspace' },
        { '<Leader>nc', '<Cmd>Neorg return<CR>', desc = 'Return' },
        { '<Leader>nw', '<Cmd>Telescope neorg switch_workspace<CR>', desc = 'Switch Workspace (via Telescope)'},
    },
    opts = {
        load = {
            ['core.defaults'] = {},
            ['core.concealer'] = {},
            ['core.integrations.telescope'] = {},
            ['core.completion'] = {
                config = {
                    engine = 'nvim-cmp',
                },
            },
            ['core.dirman'] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        notes = '~/Dropbox/Neorg',
                        cp = '~/Dropbox/Programming/Competitive/Notes',
                        osn = '~/Dropbox/OSN Informatika/Notes',
                    },
                    default = 'notes',
                },
            },
        },
    },
    config = function(_, opts)
        require('neorg').setup(opts)

        local neorg_callbacks = require('neorg.callbacks')
        neorg_callbacks.on_event('core.keybinds.events.enable_keybinds', function(_, keybinds)
            keybinds.map_event_to_mode('norg', {
                n = {
                    { '<C-f>', 'core.integrations.telescope.find_linkable' },
                    { '<Leader>nf', 'core.integrations.telescope.find_norg_files'},
                },
                i = { { '<C-l>', 'core.integrations.telescope.insert_link' } },
            }, { silent = true, noremap = true })
        end)
    end,
}
