_G.Util = {}

Util.get_word = function()
    local first_line_num, last_line_num = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
    local first_col, last_col = vim.fn.getpos("'<")[3], vim.fn.getpos("'>")[3]
    local current_word = vim.fn.getline(first_line_num, last_line_num)[1]:sub(first_col, last_col)
    return current_word
end

Util.open = function()
    local filename = vim.fn.expand('<cfile>')
    vim.loop.spawn('xdg-open', { args = { filename } })
end

Util.borders = {
    { '╭', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '╮', 'FloatBorder' },
    { '│', 'FloatBorder' },
    { '╯', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '╰', 'FloatBorder' },
    { '│', 'FloatBorder' },
}

-- See lua/mappings.lua
local get_mapper = function(mode, noremap)
    return function(lhs, rhs, opts)
        opts = opts or {}
        opts.noremap = noremap
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

Util.map = get_mapper('', false)
Util.nmap = get_mapper('n', false)
Util.imap = get_mapper('i', false)
Util.vmap = get_mapper('v', false)
Util.tmap = get_mapper('t', false)
Util.xmap = get_mapper('x', false)
Util.cmap = get_mapper('c', false)
Util.noremap = get_mapper('', true)
Util.nnoremap = get_mapper('n', true)
Util.inoremap = get_mapper('i', true)
Util.vnoremap = get_mapper('v', true)
Util.tnoremap = get_mapper('t', true)
Util.xnoremap = get_mapper('x', true)
Util.cnoremap = get_mapper('c', true)


return Util
