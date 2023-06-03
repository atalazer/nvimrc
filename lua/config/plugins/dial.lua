local M = {
    'monaqa/dial.nvim',
    keys = {
        {
            '<C-a>',
            function()
                require('dial.map').manipulate('increment', 'normal')
            end,
            mode = 'n',
            desc = 'Increment',
        },
        {
            '<C-x>',
            function()
                require('dial.map').manipulate('decrement', 'normal')
            end,
            mode = 'n',
            desc = 'Decrement',
        },
        {
            'g<C-a>',
            function()
                require('dial.map').manipulate('increment', 'gnormal')
            end,
            mode = 'n',
            desc = 'Increment',
        },
        {
            'g<C-x>',
            function()
                require('dial.map').manipulate('decrement', 'gnormal')
            end,
            mode = 'n',
            desc = 'Decrement',
        },
        {
            '<C-a>',
            function()
                require('dial.map').manipulate('increment', 'visual')
            end,
            mode = 'v',
            desc = 'Increment',
        },
        {
            '<C-x>',
            function()
                require('dial.map').manipulate('decrement', 'visual')
            end,
            mode = 'v',
            desc = 'Decrement',
        },
        {
            'g<C-a>',
            function()
                require('dial.map').manipulate('increment', 'gvisual')
            end,
            mode = 'v',
            desc = 'Increment',
        },
        {
            'g<C-x>',
            function()
                require('dial.map').manipulate('decrement', 'gvisual')
            end,
            mode = 'n',
            desc = 'Decrement',
        },
    },
    config = function()
        local augend = require('dial.augend')
        require('dial.config').augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias['%Y/%m/%d'],
                augend.date.new({
                    pattern = '%Y/%m/%d',
                    default_kind = 'day',
                }),
                augend.date.new({
                    pattern = '%d-%m-%Y',
                    default_kind = 'day',
                }),
                augend.date.new({
                    pattern = '%H:%M',
                    default_kind = 'day',
                    only_valid = true,
                }),
            },
        })

        require('dial.config').augends:on_filetype({
            markdown = {
                augend.constant.alias.alpha,
                augend.constant.alias.Alpha,
                augend.misc.alias.markdown_header,
            },
        })
    end,
}

return M
