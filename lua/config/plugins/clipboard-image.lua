return {
    'ekickx/clipboard-image.nvim',
    config = function()
        require('clipboard-image').setup({
            default = {
                affix = '![](%s)',
                img_dir = { '%:p:h', 'Assets/Image' },
                img_name = function()
                    vim.fn.inputsave()
                    local name = vim.fn.input('Name: ')
                    vim.fn.inputrestore()
                    return name
                end,
                img_handler = function(img)
                    vim.cmd('normal! f[') -- go to [
                    vim.cmd('normal! a' .. img.name) -- append text with image name
                end,
            },
        })

        local function paste_url(url)
            url = url.args
            local utils = require('clipboard-image.utils')
            local conf_utils = require('clipboard-image.config')

            local conf_toload = conf_utils.get_usable_config()
            local conf = conf_utils.load_config(conf_toload)

            utils.insert_txt(conf.affix, url)
        end

        -- Now let's create the command (works on neovim 0.7+)
        vim.api.nvim_create_user_command('PasteImgUrl', paste_url, { nargs = 1 })
    end,
}
