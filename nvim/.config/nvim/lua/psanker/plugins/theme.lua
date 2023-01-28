return {
    {
        'rose-pine/neovim',
        config = function ()
            require('rose-pine').setup({
                dark_variant = 'moon',
            })

            vim.cmd.colorscheme('rose-pine')
        end,
        priority = 1000,
        lazy = false,
    },
    {
        'NvChad/nvim-colorizer.lua',
        config = function(_)
            require('colorizer').setup({
                user_default_options = {
                    names = false,
                },
            })
        end,
        event = { 'BufReadPre', 'BufNewFile' },
    },
    'kyazdani42/nvim-web-devicons',
}
