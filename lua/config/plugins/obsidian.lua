return {
    'epwalsh/obsidian.nvim',
    keys = {
        {
            'n',
            'gf',
            function()
                if require('obsidian').util.cursor_on_markdown_link() then
                    return '<cmd>ObsidianFollowLink<CR>'
                else
                    return 'gf'
                end
            end,
            { noremap = false, expr = true },
        },
    },
    config = function()
        require('obsidian').setup({
            dir = '~/Dropbox/Digital Garden',
            use_advanced_uri = true,
            disable_frontmatter = true,
            completion = {
                nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
            },
        })
    end,
}
