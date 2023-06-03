return {
    'gaoDean/autolist.nvim',
    ft = 'markdown',
    opts = {
            colon = { -- if a line ends in a colon
                indent = true, -- if in list and line ends in `:` then create list
                indent_raw = true, -- above, but doesn't need to be in a list to work
                preferred = '-', -- what the new list starts with (can be `1.` etc)
            },
            invert = { -- Inverts the list type (ol -> ul, ul -> ol, [ ] -> [x])
                indent = true, -- when on top level list, pressing invert inverts the list and indents it
                toggles_checkbox = true, -- if pressing invert toggles checkbox
                ul_marker = '-', -- when from ordered list to unordered, set marker to whatever this is
                ol_incrementable = '1', -- same thing above but for ordered
            },
            lists = { -- configures list behavio
                markdown = {
                    'unordered',
                    'digit',
                    'ascii', -- specifies activate the ascii list type for markdown files
                    'roman', -- see below on the list types
                },
            },
            list_patterns = { -- custom list types: see README -> Configuration -> defining custom lists
                unordered = '[-+*]', -- - + *
                digit = '%d+[.)]', -- 1. 2. 3.
                ascii = '%a[.)]', -- a) b) c)
                roman = '%u*[.)]', -- I. II. III.
            },
            checkbox = {
                left = '%[', -- the left checkbox delimiter (you could change to "%(" for brackets)
                right = '%]', -- the right checkbox delim (same customisation as above)
                fill = 'x', -- if you do the above two customisations, your checkbox could be (x) instead of [x]
            },

    },
    config = function(_, opts)
        local autolist = require('autolist')
        autolist.setup(opts)
        autolist.create_mapping_hook('i', '<CR>', autolist.new)
        autolist.create_mapping_hook('i', '<Tab>', autolist.indent)
        autolist.create_mapping_hook('i', '<S-Tab>', autolist.indent, '<C-D>')
        autolist.create_mapping_hook('n', 'o', autolist.new)
        autolist.create_mapping_hook('n', 'O', autolist.new_before)
        autolist.create_mapping_hook('n', '>>', autolist.indent)
        autolist.create_mapping_hook('n', '<<', autolist.indent)
        autolist.create_mapping_hook('n', '<C-r>', autolist.force_recalculate)
        autolist.create_mapping_hook('n', '<leader>x', autolist.invert_entry, '')
    end,
}
