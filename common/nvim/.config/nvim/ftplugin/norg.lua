local wk = require('which-key')

wk.register({
    n = {
        name = 'notes',
        i = { '<cmd>Telescope neorg insert_link<CR>', '[n]otes: [i]nsert link to note' },
        s = { '<cmd>Telescope neorg find_linkable<CR>', '[n]otes: [s]earch for note and open' },
    },
}, { prefix = '<LocalLeader>' })
