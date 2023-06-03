return {
    'folke/which-key.nvim',
    config = function()
        local wk = require('which-key')
        wk.setup({
            plugins = {
                marks = false,
                registers = true,
                spelling = { enabled = true },
                presets = {
                    operators = false,
                    motions = false,
                    text_objects = false,
                    windows = false,
                    z = true,
                    g = true,
                },
            },
            operators = { gc = 'Comments' },
            key_labels = {
                ['<space>'] = 'SPC',
                ['<cr>'] = 'RET',
                ['<tab>'] = 'TAB',
                ['<leader>'] = '.',
                ['<localleader>'] = ',',
            },
            icons = {
                breadcrumb = '→',
                separator = '➜',
                group = '± ',
            },
            window = {
                border = Util.borders,
                position = 'bottom',
                margin = { 1, 3, 1, 3 },
                padding = { 2, 2, 2, 2 },
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 8,
            },
            ignore_missing = false,
            hidden = { '<silent>', '<cmd>', '<Cmd>', '<CMD>', 'lua', '<CR>', 'call', 'lua', '^:', '^ ' },
            show_help = true,
            triggers = 'auto',
            -- triggers_blacklist = {
            --     i = { ',' },
            --     n = { 's' }
            -- },
        })

        wk.register({
            b = { name = 'Browse' },
            c = { name = 'CD/CP/LSP' },
            cp = { name = 'Competitest' },
            d = { name = 'LSP (Document and Diagnostic)' },
            f = { name = 'File/Finder(Telescope)' },
            g = { name = 'Git' },
            gd = { name = 'Git Diffview' },
            h = { name = 'Gitsigns' },
            m = { name = 'Manager (Lazy and Mason)' },
            n = { name = 'Neorg' },
            r = { name = 'Code Runner' },
            t = { name = 'Toggle' },
            w = { name = 'LSP (Workspace)' },
        }, { prefix = '<leader>' })
    end,
}
