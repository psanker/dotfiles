local db = require('dashboard')

db.custom_header = {
    '███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗',
    '████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║',
    '██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║',
    '██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║',
    '██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║',
    '╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝',
}

db.header_pad = 20
db.center_pad = 5

db.custom_center = {
    {
        icon = '  ',
        desc = 'Find file                               ',
        shortcut = 'SPC f f'
    },
    {
        icon = 'ﯠ ',
        desc = ' Open Harpoon                            ',
        shortcut = 'SPC h h'
    },
    {
        icon = '  ',
        desc = 'Open file browser                       ',
        shortcut = 'SPC f b'
    },
    {
        icon = '  ',
        desc = 'Search for word                         ',
        shortcut = 'SPC f g'
    },
}
