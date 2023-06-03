return {
    'neovim/nvim-lspconfig',
    'jose-elias-alvarez/null-ls.nvim',
    'lvimuser/lsp-inlayhints.nvim',
    {
        'glepnir/lspsaga.nvim',
        opts = {
            lightbulb = { enable = false },
            symbol_in_winbar = { enable = false },
            ui = {
                border = Util.borders,
            },
        },
    },
    {
        url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
            require('lsp_lines').setup()
            vim.keymap.set('', '<Leader>tl', require('lsp_lines').toggle, { desc = 'LSP: toggle [l]sp_lines' })
        end,
    },
    -- {
    --     'ray-x/web-tools.nvim',
    --     opts = {
    --         keymaps = {
    --             rename = nil, -- by default use same setup of lspconfig
    --             repeat_rename = '.', -- . to repeat
    --         },
    --         hurl = { -- hurl default
    --             show_headers = false, -- do not show http headers
    --             floating = false, -- use floating windows (need guihua.lua)
    --             formatters = { -- format the result by filetype
    --                 json = { 'jq' },
    --                 html = { 'prettier', '--parser', 'html' },
    --             },
    --         },
    --     },
    -- },
}
