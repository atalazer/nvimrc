require('lsp.handlers')
require('lsp.diagnostics')
require('lsp.null-ls')

-- }}}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local nmap = function(keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { desc = desc, silent = true, noremap = true })
end

nmap('[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous diagnostic')
nmap(']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic')

-- ===== Global on_attach {{{
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        local lsp_formatting = function()
            vim.lsp.buf.format({
                ---@diagnostic disable-next-line: redefined-local
                filter = function(client)
                    -- apply whatever logic you want (in this example, we'll only use null-ls)
                    return client.name == 'null-ls'
                end,
                bufnr = bufnr,
            })
        end

        -- ===== Mappings
        nmap('<leader>cf', lsp_formatting, 'format file')
        nmap('gR', '<CMD>Lspsaga rename<CR>', 'rename')
        nmap('<leader>ca', '<CMD>Lspsaga code_action<CR>', 'code ation')

        nmap('gd', '<CMD>Lspsaga peek_definition<CR>', 'goto definition')
        nmap('gD', '<CMD>Lspsaga peek_type_definition<CR>', 'goto type definition')
        nmap('gi', '<Cmd>Telescope lsp_implementations<CR>', 'goto umplementation')
        nmap('gr', '<Cmd>Telescope lsp_references<CR>', 'goto references')

        nmap('<leader>ds', '<Cmd>Telescope lsp_document_symbols<CR>', 'document symbols')
        nmap('<leader>ws', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 'workspace symbols')

        -- See `:help K` for why this keymap
        nmap('K', '<CMD>Lspsaga hover_doc<CR>', 'Hover Documentation')

        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'workspace add Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'workspace remove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'workspace List Folders')

        -- Diagnostics
        nmap('<leader>dc', '<cmd>Lspsaga show_cursor_diagnostics<CR>', 'show current diagnostic')
        nmap('<leader>db', '<cmd>Lspsaga show_buf_diagnostics<CR>', 'show buffer diagnostic')

        nmap('<leader>to', '<cmd>Lspsaga outline<CR>', 'toggle outline')

        -- InlayHints
        require('lsp-inlayhints').on_attach(client, bufnr)
    end,
})
-- }}}

local servers = {
    -- tsserver = require('lsp.server.tsserver').config,
}

for lsp, config in pairs(servers) do
    if lsp == 'clangd' then
        capabilities.offsetEncoding = { 'utf-16' }
    end

    config = vim.tbl_extend('force', {
        flags = { debounce_text_changes = 150 },
        capabilities = capabilities,
    }, config)

    require('lspconfig')[lsp].setup(config)
end

local handlers = {
    function(server_name) -- default handler (optional)
        require('lspconfig')[server_name].setup({

            flags = { debounce_text_changes = 150 },
            capabilities = capabilities,
        })
    end,
    ['lua_ls'] = function()
        require('lspconfig').lua_ls.setup(require('lsp.server.lua_ls').config)
    end,
}

require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'bashls', 'clangd', 'rust_analyzer', 'gopls' },
    automatic_installation = true,
    handlers = handlers,
})
