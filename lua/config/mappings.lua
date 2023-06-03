local noremap = Util.noremap
local nnoremap = Util.nnoremap
local inoremap = Util.inoremap
local vnoremap = Util.vnoremap
local cnoremap = Util.cnoremap

-- Files {{{
-- Save file
nnoremap('<leader>fw', '<CMD>update<CR>', { desc = 'File: Write' })
nnoremap('<C-s>', '<Cmd>update<cr>', { desc = 'Save File' })
inoremap('<C-s>', '<Esc><Esc><Cmd>update<cr>', { desc = 'Save File' })
vnoremap('<C-s>', '<Esc><Esc><Cmd>update<cr>', { desc = 'Save File' })

-- Source file
nnoremap('<leader>fs', "<CMD>source % | echo 'Source current file!'<CR>", { desc = 'File: source current' })

nnoremap('<Leader>cd', '<Cmd>cd %:h<CR>', { desc = 'Change directory' })

-- }}}

-- Search {{{
nnoremap('/', 'ms/', { desc = 'Keeps jumplist after forward searching' })
nnoremap('?', 'ms?', { desc = 'Keeps jumplist after backward searching' })
nnoremap('<Esc><Esc>', '<CMD>nohl<CR>', { desc = 'Toggle search highlight' })
nnoremap('<M-n>', '<CMD>nohl<CR>', { desc = 'Toggle search highlight' })

noremap('n', '"Nn"[v:searchforward]', {
    expr = true,
    desc = 'Better forward N behaviour',
})
noremap('N', '"nN"[v:searchforward]', {
    expr = true,
    desc = 'Better backward N behaviour',
})

-- }}}

-- Windows {{{
nnoremap('<C-k>', '<C-w><C-k>', { desc = 'Go to the top window' })
nnoremap('<C-j>', '<C-w><C-j>', { desc = 'Go to the bottom window' })
nnoremap('<C-l>', '<C-w><C-l>', { desc = 'Go to the right window' })
nnoremap('<C-h>', '<C-w><C-h>', { desc = 'Go to the left window' })

nnoremap('<A-k>', '<Cmd>resize +3<CR>', { desc = 'Resize window up' })
nnoremap('<A-j>', '<Cmd>resize -3<CR>', { desc = 'Resize window down' })
nnoremap('<A-l>', '<Cmd>vertical resize +3<CR>', { desc = 'Resize window left' })
nnoremap('<A-h>', '<Cmd>vertical resize -3<CR>', { desc = 'Resize window right' })
-- }}}

-- Buffer {{{
noremap('<Tab>', '<CMD>bn<CR>', { desc = 'Go to next buffer' })
noremap('<S-Tab>', '<CMD>bp<CR>', { desc = 'Go to previous buffer' })

local function close_buffer()
    if vim.bo.buftype == 'terminal' then
        vim.cmd(vim.bo.buflisted and 'set nobl | enew' or 'hide')
    elseif vim.bo.modified then
        print('save the file first!')
    else
        bufnr = vim.api.nvim_get_current_buf()
        vim.cmd('bp')
        vim.cmd('bd' .. bufnr)
    end
end
nnoremap('<leader>fc', close_buffer, { desc = 'File: close' })
nnoremap('<A-q>', close_buffer, { desc = 'close file' })
nnoremap('<A-S-q>', '<C-o>', { desc = 'Restore closed file' })

--}}}

-- Others {{{
inoremap('<C-W>', '<C-S-W>', {
    desc = 'Delete word backwards',
})

vnoremap('<', '<gv', { desc = 'Dedent current selection' })
vnoremap('>', '>gv', { desc = 'Indent current selection' })

nnoremap('u', '<CMD>undo<CR>', { desc = 'Undo' })
nnoremap('U', '<CMD>redo<CR>', { desc = 'Redo' })
nnoremap('Y', 'y$', { desc = 'Copy current line' })

-- Alt-Backspace to Delete Word
inoremap('<A-BS>', '<C-w>')
nnoremap('<A-BS>', 'i<C-w>')
cnoremap('<A-BS>', '<C-w>')

-- }}}
