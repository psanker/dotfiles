local set = vim.opt
local g = vim.g

g.my_colorscheme = 'rose-pine'

-- require('catppuccin').setup({
--     flavour = 'mocha'
-- })

-- require('tokyonight').setup({
--     style = 'night'
-- })

require('rose-pine').setup({
    dark_variant = 'moon'
})

local function element_in(el, tab)
    local els_set = {}

    for _, val in ipairs(tab) do
        els_set[val] = true
    end

    return els_set[el] ~= nil
end

local function word_count()
    local out = ''
    if element_in(vim.bo.filetype, { 'md', 'markdown', 'txt', 'rmd' }) then
        local wc = 0
        if vim.fn.wordcount().visual_words ~= nil then
            wc = vim.fn.wordcount().visual_words
        else
            wc = vim.fn.wordcount().words
        end

        if wc == 1 then
            out = tostring(wc) .. ' word'
        else
            out = tostring(wc) .. ' words'
        end
    end

    return out
end

require("lualine").setup({
    options = {
        theme = 'rose-pine'
    },
    sections = {
        lualine_x = {
            { word_count },
            'encoding',
            'fileformat',
            'filetype',
        }
    }
})

function DrawTheme()
    vim.cmd("colorscheme " .. g.my_colorscheme)
    set.background = 'dark'
end

DrawTheme()
