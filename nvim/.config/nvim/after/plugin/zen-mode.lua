local Remap = require('psanker.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<Leader>zz', function()
    require('zen-mode').toggle({
        window = {
            width = .75,
        },
    })
end)
