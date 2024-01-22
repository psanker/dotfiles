return {
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
    {
        'kyazdani42/nvim-web-devicons',
        event = { 'BufEnter' },
    },
}
