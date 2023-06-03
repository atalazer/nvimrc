return {
    'williamboman/mason.nvim',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
        require('mason').setup({
            max_concurrent_installers = 4,
            ui = {
                border = Util.borders,
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
                keymaps = {
                    toggle_package_expand = '<CR>',
                    install_package = 'i',
                    update_package = 'u',
                    check_package_version = 'c',
                    update_all_packages = 'U',
                    check_outdated_packages = 'C',
                    uninstall_package = 'X',
                    cancel_installation = '<C-c>',
                    apply_language_filter = '<C-f>',
                },
            },
        })
    end,
}
