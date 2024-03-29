local signs = {
    Error = " ",
    Warn = " ",
    Info = " ",
    Hint = " ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    underline = true,
    signs = true,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = false,
    virtual_lines = false,
    -- virtual_text = {
    --     prefix = "■ ",
    --     spacing = 4,
    --     source = "always",
    -- },
})

