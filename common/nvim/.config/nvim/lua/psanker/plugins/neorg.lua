return {
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        ft = "norg",
        dependencies = {
            { 'nvim-neorg/neorg-telescope' },
        },
        config = function()
            require('neorg').setup({
                load = {
                    ['core.defaults'] = {},
                    ['core.concealer'] = {},
                    ['core.dirman'] = {
                        config = {
                            workspaces = {
                                pkm = '~/personal/pkm',
                            },
                        },
                    },
                    ['core.integrations.telescope'] = {},
                }
            })
        end,
    },
}
