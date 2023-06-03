local null_ls = require('null-ls')

-- local h = require("null-ls.helpers")
-- local m = null_ls.methods
local b = null_ls.builtins

null_ls.setup({
    sources = {
        b.code_actions.gitsigns,
        b.hover.dictionary,

        b.diagnostics.shellcheck,
        b.diagnostics.fish,

        -- -- Spell check that has better tooling all stored locally
        -- -- https://github.com/streetsidesoftware/cspell
        -- b.diagnostics.cspell.with({
        --     extra_args = { '--config', '~/.cspell.json' },
        -- }),
        -- b.code_actions.cspell.with({
        --     extra_args = { '--config', '~/.cspell.json' },
        -- }),

        b.formatting.prettierd.with({
            env = {
                PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath('config') .. '/.prettierrc',
            },
        }),
        b.formatting.clang_format,

        b.formatting.shfmt.with({
            filetypes = { 'sh', 'bash', 'zsh' },
            extra_args = { '-i', vim.bo.shiftwidth or 4, '-s', '$FILENAME' },
        }),

        b.formatting.stylua.with({
            extra_args = {
                '--config-path',
                vim.env.HOME .. '/.config/nvim/.stylua.toml',
                '-',
            },
        }),

        b.formatting.trim_newlines.with({
            disabled_filetypes = { 'markdown', 'tex' },
        }),
        b.formatting.trim_whitespace.with({
            disabled_filetypes = { 'markdown', 'tex' },
        }),

    },
})
