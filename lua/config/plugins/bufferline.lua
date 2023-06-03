return {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    keys = {
        { '<leader>bp', '<Cmd>BufferLinePick<CR>', desc = 'Pick Buffer' },
        { '<leader>tp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
    },
    config = function()
        local bufferline = require('bufferline')
        local map = vim.api.nvim_set_keymap

        for i = 1, 9 do
            map(
                'n',
                ('<A-%s>'):format(i),
                ('<Cmd>BufferLineGoToBuffer %s<CR>'):format(i),
                { silent = true, noremap = true }
            )
            map(
                'n',
                ('<A-S-%s>'):format(i),
                ('<Cmd>lua require("bufferline").move_to(%s)<CR>'):format(i),
                { silent = true, noremap = true }
            )
        end

        bufferline.setup({
            options = {
                mode = 'buffers',
                style_preset = bufferline.style_preset.default,
                themable = true,

                numbers = 'none',
                close_command = 'bdelete! %d',
                right_mouse_command = 'bdelete! %d',
                left_mouse_command = 'buffer %d',

                buffer_close_icon = '󰅖',
                modified_icon = '●',
                close_icon = '',
                left_trunc_marker = '',
                right_trunc_marker = '',
                max_name_length = 20,
                max_prefix_length = 10,
                truncate_names = true,
                tab_size = 24,

                diagnostics = 'nvim_lsp',
                diagnostics_update_in_insert = false,

                always_show_bufferline = true,
                color_icons = true,
                enforce_regular_tabs = false,
                persist_buffer_sort = true,
                separator_style = 'slant',
                show_buffer_close_icons = true,
                show_buffer_icons = true,
                show_close_icon = true,
                show_duplicate_prefix = true,
                show_tab_indicators = true,

                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { 'close' },
                },

                offsets = {
                    {
                        filetype = 'neo-tree',
                        text = 'File Explorer',
                        text_align = 'center',
                        separator = true,
                    },
                },
                groups = {
                    options = {
                        toggle_hidden_on_enter = true,
                    },
                    items = {
                        {
                            name = 'Tests', -- Mandatory
                            highlight = { gui = 'underline', guisp = 'blue' }, -- Optional
                            priority = 2, -- determines where it will appear relative to other groups (Optional)
                            icon = '', -- Optional
                            matcher = function(buf) -- Mandatory
                                return buf.name:match('%_test') or buf.name:match('%_spec')
                            end,
                        },
                    },
                },
            },
        })
    end,
}
