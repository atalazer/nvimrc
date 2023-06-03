return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'BufReadPost',
        dependencies = {
            'joosepalviste/nvim-ts-context-commentstring',
            'HiPhish/nvim-ts-rainbow2',
        },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'bash',
                    'c',
                    'cpp',
                    'css',
                    'fish',
                    'html',
                    'javascript',
                    'json',
                    'latex',
                    'lua',
                    'markdown',
                    'markdown_inline',
                    'norg',
                    'python',
                    'query',
                    'scss',
                    'yaml',
                    'comment',
                },
                highlight = {
                    enable = true,
                    use_languagetree = true,
                },
                indent = { enable = true },
                rainbow = {
                    enable = true,
                    query = 'rainbow-parens',
                    strategy = require('ts-rainbow.strategy.global'),
                },
                context_commentstring = {
                    enable = true,
                },
            })
        end,
    },
}
