return {
    'echasnovski/mini.nvim',
    config = function()
        require('mini.align').setup({
            mappings = {
                start = 'ga',
                start_with_preview = 'gA',
            },
        })

        require('mini.cursorword').setup({
            delay = 250,
        })

        require('mini.trailspace').setup({})
        require('mini.misc').setup()
    end,
}
