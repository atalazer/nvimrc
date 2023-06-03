local M = {}

M.config = {
    filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
    init_options = {
        documentFormatting = false,
    },
    root_dir = vim.loop.cwd,
}

return M
