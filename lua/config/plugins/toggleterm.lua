return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        require('toggleterm').setup({
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return vim.o.columns * 0.4
                end
            end,
        })
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            cmd = 'lazygit',
            dir = 'git_dir',
            direction = 'float',
            float_opts = {
                -- border = 'rounded',
                border = Util.borders,
            },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd('startinsert!')
                vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
            end,
            -- function to run on closing the terminal
            on_close = function()
                vim.cmd('startinsert!')
            end,
        })

        vim.api.nvim_create_user_command('Lazygit', function() lazygit:toggle() end, {})

        vim.api.nvim_set_keymap(
            'n',
            '<A-t>',
            '<Cmd>ToggleTerm<CR>',
            { noremap = true, silent = true, desc = 'Toogle Term' }
        )
        vim.api.nvim_set_keymap(
            't',
            '<A-t>',
            [[<C-\><C-n><Cmd>ToggleTerm<CR>]],
            { noremap = true, silent = true, desc = 'Toogle Term' }
        )
        vim.api.nvim_set_keymap(
            'n',
            '<leader>tg',
            '<cmd>Lazygit<CR>',
            { noremap = true, silent = true, desc = 'Toggle LazyGit' }
        )
    end,
}
