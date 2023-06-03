return {
    'lalitmee/browse.nvim',
    keys = {
        { '<leader>bs', '<Cmd>InputSearch<CR>', desc = 'Browse in web' },
        { '<leader>bd', '<Cmd>DevdocsSearch<CR>', desc = 'Browse in Devdocs' },
        { '<leader>bm', '<Cmd>MdnSearch<CR>', desc = 'Browse in MDN' },
        { '<leader>bd', '<Cmd>Bookmarks<CR>', desc = 'Bookmarks Search' },
    },
    config = function()
        local reddit_url = 'https://r.nf/'
        local youtube_url = 'https://r.nf/'
        local bookmarks = {
            github = {
                name = 'Search in GitHub',
                search = 'https://github.com/search?q=%s',
                topics = 'https://github.com/topics/%s',
            },
            reddit = {
                name = 'Search in Reddit',
                search = reddit_url .. 'search?q=%s',
                neovim = reddit_url .. 'r/neovim/search?q=%s',
                unixporn = reddit_url .. 'r/unixporn/search?q=%s',
            },
            youtube = {
                name = 'Search in Youtube',
                search = youtube_url .. 'search?q=%s',
            },
        }

        local browse = require('browse')
        browse.setup({
            provider = 'google', -- duckduckgo, bing
            bookmarks = bookmarks,
        })

        function command(name, rhs)
            vim.api.nvim_create_user_command(name, rhs, {})
        end
        command('InputSearch', function()
            browse.input_search()
        end)
        command('Browse', function()
            browse.browse({ bookmarks = bookmarks })
        end)
        command('Bookmarks', function()
            browse.open_bookmarks({ bookmarks = bookmarks })
        end)
        command('DevdocsSearch', function()
            browse.devdocs.search()
        end)
        command('DevdocsFiletypeSearch', function()
            browse.devdocs.search_with_filetype()
        end)
        command('MdnSearch', function()
            browse.mdn.search()
        end)
    end,
}
