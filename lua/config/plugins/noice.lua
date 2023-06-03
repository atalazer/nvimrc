return {
    'folke/noice.nvim',
    enabled = false,
    event = 'VeryLazy',
    config = function()
        require('noice').setup({
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = false,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        })

        vim.keymap.set('c', '<S-Enter>', function()
            require('noice').redirect(vim.fn.getcmdline())
        end, { desc = 'Redirect Cmdline' })

        require('telescope').load_extension('noice')
    end,
}
