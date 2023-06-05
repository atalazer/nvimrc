local options = { noremap = true, silent = false }
return {
    'CRAG666/code_runner.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
        { '<leader>re', '<CMD>RunCode<CR>', options, desc = 'Run and Execute' },
        { '<leader>rf', '<CMD>RunFile<CR>', options, desc = 'Run File' },
        { '<leader>rft', '<CMD>RunFile tab<CR>', options, desc = 'Run File in new tab' },
        { '<leader>rp', '<CMD>RunProject<CR>', options, desc = 'Run Project' },
        { '<leader>rc', '<CMD>RunClose<CR>', options, desc = 'Run Close' },
    },
    config = function()
        require('code_runner').setup({
            focus = true,
            startinsert = true,
            filetype = {
                c = 'cd "$dir" && gcc "$fileName" -o "$fileNameWithoutExt" && "$dir/$fileNameWithoutExt" && rm "$dir/$fileNameWithoutExt"',
                -- cpp = 'cd "$dir" && g++ -Wall -Wextra -O2 "$fileName" -o "$fileNameWithoutExt" && "$dir/$fileNameWithoutExt" && rm "$dir/$fileNameWithoutExt"',
                cpp = 'cd "$dir" && g++ -std=c++17 -Wall -Wextra -O2 "$fileName" -o "$fileNameWithoutExt" && "$dir/$fileNameWithoutExt" && rm "$dir/$fileNameWithoutExt"',
                rust = 'cd "$dir" && rustc "$fileName" && "$dir/$fileNameWithoutExt" && rm "$dir/$fileNameWithoutExt"',
            },
        })
    end,
}
