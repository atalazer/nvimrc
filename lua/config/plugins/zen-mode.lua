return {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = {
        { '<Leader>tz', '<Cmd>ZenMode<CR>', desc = 'Toggle Zen Mode' },
    },
    opts = {
        window = {
            backdrop = 0.9, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
            width = 0.8, -- width of the Zen window
            height = 1, -- height of the Zen window
            options = {
                signcolumn = 'no', -- disable signcolumn
                number = false, -- disable number column
                relativenumber = false, -- disable relative numbers
                cursorline = false, -- disable cursorline
                cursorcolumn = false, -- disable cursor column
                foldcolumn = '0', -- disable fold column
                list = false, -- disable whitespace characters
            },
        },
        plugins = {
            options = {
                enabled = true,
                ruler = false, -- disables the ruler text in the cmd line area
                showcmd = false, -- disables the command in the last line of the screen
            },
            twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
            gitsigns = { enabled = false }, -- disables git signs
            tmux = { enabled = false }, -- disables the tmux statusline
            -- this will change the font size on kitty when in zen mode
            -- to make this work, you need to set the following kitty options:
            -- - allow_remote_control socket-only
            -- - listen_on unix:/tmp/kitty
            kitty = {
                enabled = false,
                font = '+4', -- font size increment
            },
            -- this will change the font size on alacritty when in zen mode
            -- requires  Alacritty Version 0.10.0 or higher
            -- uses `alacritty msg` subcommand to change font size
            alacritty = {
                enabled = false,
                font = '14', -- font size
            },
            -- this will change the font size on wezterm when in zen mode
            -- See alse also the Plugins/Wezterm section in this projects README
            wezterm = {
                enabled = false,
                -- can be either an absolute font size or the number of incremental steps
                font = '+4', -- (10% increase per step)
            },
        },
        -- -- callback where you can add custom code when the Zen window opens
        on_open = function(--[[ win ]])
            vim.cmd('set wrap')
        end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function()
            vim.cmd('set nowrap')
        end,
    },
}
