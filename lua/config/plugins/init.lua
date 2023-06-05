return {
    -- dependencies {{{
    { 'tami5/sqlite.lua', lazy = true },
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'muniftanjim/nui.nvim', lazy = true },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    -- }}}

    -- MUST LOAD FIRST {{{
    {
        'willothy/flatten.nvim',
        lazy = false,
        priority = 1002,
        opts = {},
    },

    {
        'glacambre/firenvim',
        enabled = false,
        build = function()
            vim.fn['firenvim#install'](0)
        end,
    },

    -- }}}

    -- Themes {{{
    {
        'atalazer/wally.nvim',
        dev = true,
        build = './setup.sh',
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
    },

    -- }}}

    -- UI Enchented {{{
    -- ./veil.lua
    -- ./noice.lua
    -- ./lualine.lua
    -- ./bufferline.lua
    -- ./neo-tree.lua
    -- ./notify.lua
    -- ./which-key.lua
    -- ./telescope.lua
    -- ./indent-blankline.lua

    {
        'mvllow/modes.nvim',
        opts = {
            colors = {
                copy = '#f5c359',
                delete = '#c75c6a',
                insert = '#78ccc5',
                visual = '#9745be',
            },
            line_opacity = 0.15,
            set_cursor = true,
            set_cursorline = true,
            set_number = true,
            ignore_filetypes = { 'neo-tree', 'TelescopePrompt', 'neogitstatus', 'lazy', 'veil' },
        },
    },

    -- }}}

    -- language {{{
    -- ./treesitter.lua
    -- ./markdown.lua
    {
        'lervag/vimtex',
        ft = { 'tex', 'latex' },
        init = function()
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_quickfix_mode = 0
        end,
    },

    -- }}}

    -- completion and snippets {{{
    -- ./lsp.lua
    -- ./mason.lua
    -- ./cmp.lua

    {
        'mattn/emmet-vim',
        cmd = 'EmmetInstall',
        init = function()
            vim.g.user_emmet_install_global = 0
            vim.g.user_emmet_mode = 'in'
            vim.g.user_emmet_leader_key = ','
            vim.cmd('autocmd FileType html,css EmmetInstall')
        end,
    },

    -- }}}

    -- helper {{{
    -- ./autolist.lua
    -- ./autopairs.lua
    -- ./competitest.lua
    -- ./code_runner.lua
    -- ./dial.lua

    {
        'numToStr/Comment.nvim',
        opts = {
            toggler = { line = 'gcc', block = 'gbc' },
            opleader = { line = 'gc', block = 'gb' },
        },
    },

    {
        'phaazon/hop.nvim',
        keys = {
            { '<A-a>', '<Cmd>HopChar1<CR>', desc = 'Hop Char 1' },
            { '<A-s>', '<Cmd>HopChar2<CR>', desc = 'Hop Char 2' },
            { '<A-w>', '<Cmd>HopWord<CR>', desc = 'Hop Word' },
        },
        opts = {
            keys = 'qwerasdfiojkl',
            jump_on_sole_occurrence = true,
            case_insensitive = false,
        },
    },

    {
        'jinh0/eyeliner.nvim',
        opts = {
            highlight_on_key = true,
            dim = true,
        },
    },

    {
        'nguyenvukhang/nvim-toggler',
        keys = {
            {
                '<leader><leader>',
                [[<Cmd>lua require('nvim-toggler').toggle()<CR>]],
                desc = 'Toggle Word Under Cursor',
            },
        },
        opts = {
            inverses = {
                ['inc'] = 'dec',
                ['increment'] = 'decrement',
                ['man'] = 'woman',
                ['new'] = 'old',
                ['<'] = '>',
                ['=='] = '!=',
            },
            remove_default_keybinds = true,
            remove_default_inverses = false,
        },
    },

    {
        'chrisgrieser/nvim-spider',
        keys = {
            { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' }, desc = 'Spider-w' },
            { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' }, desc = 'Spider-e' },
            { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' }, desc = 'Spider-b' },
            { 'ge', "<cmd>lua require('spider').motion('ge')<CR>", mode = { 'n', 'o', 'x' }, desc = 'Spider-ge' },
        },
        opts = {},
    },
    -- }}}

    -- git {{{
    -- ./neogit.lua
    -- ./gitsigns.lua
    -- }}}

    -- misc {{{
    -- ./colorizer.lua
    -- ./obsidian.lua
    -- ./mini.lua
    -- ./clipboard-image.lua
    -- ./zen-mode.lua

    'jghauser/mkdir.nvim',

    { 'utilyre/sentiment.nvim', version = '*', config = true },

    {
        'JellyApple102/easyread.nvim',
        cmd = 'EasyreadToggle',
        keys = {
            { '<Leader>te', '<Cmd>EasyreadToggle<CR>', desc = 'Toggle Easyread(Bionic Reader)' },
            { '<Leader>tr', '<Cmd>ZenMode<CR><Cmd>EasyreadToggle<CR>', desc = 'Toggle Read Mode (EasyRead+ZenMode)' },
        },
        opts = {
            hlValues = {
                ['1'] = 1,
                ['2'] = 1,
                ['3'] = 2,
                ['4'] = 2,
                ['fallback'] = 0.4,
            },
            hlgroupOptions = { link = 'Bold' },
            fileTypes = { 'text' },
            saccadeInterval = 0,
            saccadeReset = false,
            updateWhileInsert = true,
        },
    },

    {
        'max397574/better-escape.nvim',
        opts = {
            mapping = { 'jj', 'kk' },
            keys = function()
                return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
            end,
        },
    },

    {
        'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup({
                mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
                hide_cursor = false,
                stop_eof = true,
                respect_scrolloff = false,
                cursor_scrolls_alone = true,
                easing_function = 'sine',
            })
            local t = {}
            t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '350' } }
            t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '350' } }
            t['<PageUp>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '500' } }
            t['<PageDown>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '500' } }
            require('neoscroll.config').set_mappings(t)
        end,
    },

    {
        'jbyuki/venn.nvim',
        config = function()
            -- venn.nvim: enable or disable keymappings
            function _G.Toggle_venn()
                local venn_enabled = vim.inspect(vim.b.venn_enabled)
                if venn_enabled == 'nil' then
                    vim.b.venn_enabled = true
                    vim.cmd([[setlocal ve=all]])
                    -- draw a line on HJKL keystokes
                    vim.api.nvim_buf_set_keymap(0, 'n', 'J', '<C-v>j:VBox<CR>', { noremap = true })
                    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<C-v>k:VBox<CR>', { noremap = true })
                    vim.api.nvim_buf_set_keymap(0, 'n', 'L', '<C-v>l:VBox<CR>', { noremap = true })
                    vim.api.nvim_buf_set_keymap(0, 'n', 'H', '<C-v>h:VBox<CR>', { noremap = true })
                    -- draw a box by pressing "f" with visual selection
                    vim.api.nvim_buf_set_keymap(0, 'v', 'f', ':VBox<CR>', { noremap = true })
                else
                    vim.cmd([[setlocal ve=]])
                    vim.cmd([[mapclear <buffer>]])
                    vim.b.venn_enabled = nil
                end
            end
            -- toggle keymappings for venn using <leader>v
            vim.api.nvim_set_keymap('n', '<leader>tv', ':lua Toggle_venn()<CR>', { noremap = true })
        end,
    },

    -- }}}
}
