return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-frecency.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
    },
    cmd = 'Telescope',
    keys = {
        { '<C-p>', '<CMD>Telescope fd<CR>', desc = 'Find Files' },
        { '<leader>fb', '<CMD>Telescope file_browser<CR>', desc = 'open files' },
        { '<leader>fh', '<CMD>Telescope oldfiles<CR>', desc = 'oldfiles (file history)' },
        { '<leader>fl', '<CMD>Telescope live_grep<CR>', desc = 'live Grep' },
        { '<leader>fk', '<CMD>Telescope keymaps<CR>', desc = 'keymaps' },
        { '<leader>ff', '<CMD>TFrecency<CR>', desc = 'frecency' },
        { '<leader>fg', '<CMD>TGlow<CR>', desc = 'frecency' },
    },
    config = function()
        local telescope = require('telescope')
        local previewers = require('telescope.previewers')
        local actions = require('telescope.actions')
        local action_layout = require('telescope.actions.layout')
        local fb_actions = require('telescope._extensions.file_browser.actions')

        local no_preview = function()
            return require('telescope.themes').get_dropdown({
                borderchars = {
                    { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                    prompt = { '─', '│', ' ', '│', '╭', '╮', '╯', '╰' },
                    result = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                    preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                },
                layout_config = {
                    width = 0.8,
                },
                previewer = false,
            })
        end

        local new_maker = function(filepath, bufnr, opts)
            opts = opts or {}
            filepath = vim.fn.expand(filepath)
            vim.loop.fs_stat(filepath, function(_, stat)
                if not stat then
                    return
                end
                if stat.size > 100000 then
                    return
                else
                    previewers.buffer_previewer_maker(filepath, bufnr, opts)
                end
            end)
        end

        local SETTINGS = {
            defaults = {
                file_previewer = previewers.vim_buffer_cat.new,
                grep_previewer = previewers.vim_buffer_vimgrep.new,
                qflist_previewer = previewers.vim_buffer_qflist.new,
                buffer_previewer_maker = new_maker,
                scroll_strategy = 'cycle',
                selection_strategy = 'reset',
                borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                color_devicons = true,
                use_less = true,
                set_env = { ['COLORTERM'] = 'truecolor' },
                layout_strategy = 'flex',
                layout_config = {
                    width = 0.8,
                    height = 0.9,
                    horizontal = {
                        prompt_position = 'bottom',
                        preview_cutoff = 120,
                        preview_width = 0.70,
                    },
                    vertical = {
                        preview_cutoff = 30,
                        preview_height = 0.70,
                    },
                    center = {
                        preview_cutoff = 40,
                    },
                },
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--trim',
                },
                mappings = {
                    i = {
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-v>'] = actions.select_vertical,
                        ['<C-x>'] = actions.select_horizontal,
                        ['<C-t>'] = actions.select_tab,
                        ['<C-c>'] = actions.close,
                        -- ['<C-u>'] = actions.preview_scrolling_up,
                        ['<C-u>'] = false,
                        ['<PageUp>'] = actions.preview_scrolling_up,
                        ['<C-d>'] = actions.preview_scrolling_down,
                        ['<PageDown>'] = actions.preview_scrolling_down,
                        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                        ['<Tab>'] = actions.toggle_selection,
                        ['<M-p>'] = action_layout.toggle_preview,
                    },
                    n = {
                        ['<CR>'] = actions.select_default + actions.center,
                        ['<C-v>'] = actions.select_vertical,
                        ['<C-x>'] = actions.select_horizontal,
                        ['<C-t>'] = actions.select_tab,
                        ['<Esc>'] = actions.close,
                        ['j'] = actions.move_selection_next,
                        ['k'] = actions.move_selection_previous,
                        ['<C-u>'] = actions.preview_scrolling_up,
                        ['<PageUp>'] = actions.preview_scrolling_up,
                        ['<C-d>'] = actions.preview_scrolling_down,
                        ['<PageDown>'] = actions.preview_scrolling_down,
                        ['<C-q>'] = actions.send_to_qflist,
                        ['<Tab>'] = actions.toggle_selection,
                        ['<M-p>'] = action_layout.toggle_preview,
                    },
                },
                preview = {
                    mime_hook = function(filepath, bufnr, opts)
                        ---@diagnostic disable-next-line: redefined-local
                        local is_image = function(filepath)
                            local image_extensions = { 'png', 'jpg' } -- Supported image formats
                            local split_path = vim.split(filepath:lower(), '.', { plain = true })
                            local extension = split_path[#split_path]
                            return vim.tbl_contains(image_extensions, extension)
                        end
                        if is_image(filepath) then
                            local term = vim.api.nvim_open_term(bufnr, {})
                            local function send_output(_, data, _)
                                for _, d in ipairs(data) do
                                    vim.api.nvim_chan_send(term, d .. '\r\n')
                                end
                            end
                            vim.fn.jobstart({
                                'catimg',
                                filepath, -- Terminal image viewer command
                            }, { on_stdout = send_output, stdout_buffered = true })
                        else
                            require('telescope.previewers.utils').set_preview_message(
                                bufnr,
                                opts.winid,
                                'Binary cannot be previewed'
                            )
                        end
                    end,
                },
            },
            pickers = {
                find_files = {
                    find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
                    file_ignore_patterns = {
                        '%.svg',
                        '%.png',
                        '%.jpg',
                        '%.webp',
                        '%.mp3',
                        '%.mp4',
                        '%.mkv',
                        'node_modules',
                    },
                    mappings = {
                        n = {
                            ['cd'] = function(prompt_bufnr)
                                local selection = require('telescope.actions.state').get_selected_entry()
                                local dir = vim.fn.fnamemodify(selection.path, ':p:h')
                                require('telescope.actions').close(prompt_bufnr)
                                -- Depending on what you want put `cd`, `lcd`, `tcd`
                                vim.cmd(string.format('silent lcd %s', dir))
                            end,
                        },
                    },
                },
                lsp_code_actions = no_preview(),
                lsp_references = no_preview(),
                lsp_implementations = no_preview(),
                lsp_document_symbols = no_preview(),
                lsp_dynamic_workspace_symbols = no_preview(),
                oldfiles = no_preview(),
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
                frecency = {
                    show_scores = false,
                    show_unindexed = true,
                    disable_devicons = false,
                    ignore_patterns = { '*.git/*', '*/tmp/*', '**.cache**' },
                },
                file_browser = {
                    theme = 'ivy',
                    hijack_netrw = true,
                    mappings = {
                        ['i'] = {
                            ['<A-c>'] = fb_actions.create,
                            ['<S-CR>'] = fb_actions.create_from_prompt,
                            ['<A-r>'] = fb_actions.rename,
                            ['<A-m>'] = fb_actions.move,
                            ['<A-y>'] = fb_actions.copy,
                            ['<A-d>'] = fb_actions.remove,
                            ['<C-o>'] = fb_actions.open,
                            ['<C-g>'] = fb_actions.goto_parent_dir,
                            ['<C-e>'] = fb_actions.goto_home_dir,
                            ['<C-w>'] = fb_actions.goto_cwd,
                            ['<C-t>'] = fb_actions.change_cwd,
                            ['<C-f>'] = fb_actions.toggle_browser,
                            ['<C-h>'] = fb_actions.toggle_hidden,
                            ['<C-s>'] = fb_actions.toggle_all,
                            ['<bs>'] = fb_actions.backspace,
                        },
                        ['n'] = {
                            ['c'] = fb_actions.create,
                            ['r'] = fb_actions.rename,
                            ['m'] = fb_actions.move,
                            ['y'] = fb_actions.copy,
                            ['d'] = fb_actions.remove,
                            ['o'] = fb_actions.open,
                            ['g'] = fb_actions.goto_parent_dir,
                            ['e'] = fb_actions.goto_home_dir,
                            ['w'] = fb_actions.goto_cwd,
                            ['t'] = fb_actions.change_cwd,
                            ['f'] = fb_actions.toggle_browser,
                            ['h'] = fb_actions.toggle_hidden,
                            ['s'] = fb_actions.toggle_all,
                        },
                    },
                },
            },
        }

        local frecency = function()
            telescope.extensions.frecency.frecency(no_preview())
        end

        local glow_previewer = function()
            return require('telescope.builtin').fd({
                previewer = previewers.new_termopen_previewer({
                    get_command = function(selection)
                        return { 'glow', selection.value }
                    end,
                }),
            })
        end

        vim.api.nvim_create_user_command('TFrecency', frecency, {})
        vim.api.nvim_create_user_command('TGlow', glow_previewer, {})

        telescope.setup(SETTINGS)
        telescope.load_extension('fzf')
        telescope.load_extension('frecency')
        telescope.load_extension('file_browser')
        telescope.load_extension('find_template')
    end,
}
