return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'f3fora/cmp-spell',
        {
            'roobert/tailwindcss-colorizer-cmp.nvim',
            opts = { color_square_width = 2 },
        },
        {
            'L3MON4D3/LuaSnip',
            version = '1.*',
            dependencies = {
                'saadparwaiz1/cmp_luasnip',
                'honza/vim-snippets',
                'evesdropper/luasnip-latex-snippets.nvim',
            },
            build = 'make install_jsregexp',
            opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
            config = function()
                require('luasnip.loaders.from_snipmate').lazy_load()
                require('luasnip.loaders.from_snipmate').lazy_load({ paths = vim.fn.stdpath('config')  .. '/snippets'})
            end,
        },
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        -- see cmp.setup.mappings for context
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
        end

        cmp.setup({
            preselect = cmp.PreselectMode.Item,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            formatting = {
                format = require('tailwindcss-colorizer-cmp').formatter,
            },
            sources = cmp.config.sources({
                { name = 'path', priority = 99 },
                { name = 'luasnip', option = { show_autosnippets = true } },
                { name = 'nvim_lsp' },
            }, {
                { name = 'spell', keyword_length = 3 },
                { name = 'buffer', keyword_length = 3 },
            }),
            mapping = {
                ['<C-d>'] = cmp.mapping.scroll_docs(-5),
                ['<C-f>'] = cmp.mapping.scroll_docs(5),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<A-e>'] = cmp.mapping.close(),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            },
            enabled = function()
                -- disable completion in comments {{{
                local context = require('cmp.config.context')
                if vim.api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
                end
                -- }}}
            end,
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                { name = 'cmdline' },
            }),
        })
    end,
}
