local p = require('rose-pine.palette')
local lualine = require('lualine')

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

local lualine_theme = {
    normal = {
        a = { bg = p.surface, fg = p.rose },
        b = { bg = p.surface, fg = p.rose },
        c = { bg = p.surface, fg = p.subtle },
    },
    insert = {
        a = { bg = p.surface, fg = p.foam },
        b = { bg = p.surface, fg = p.foam },
        c = { bg = p.surface, fg = p.subtle },
    },
    visual = {
        a = { bg = p.surface, fg = p.iris },
        b = { bg = p.surface, fg = p.iris },
        c = { bg = p.surface, fg = p.subtle },
    },
    replace = {
        a = { bg = p.surface, fg = p.pine },
        b = { bg = p.surface, fg = p.pine },
        c = { bg = p.surface, fg = p.subtle },
    },
    command = {
        a = { bg = p.surface, fg = p.love },
        b = { bg = p.surface, fg = p.love },
        c = { bg = p.surface, fg = p.subtle },
    },
    inactive = {
        a = { bg = p.surface, fg = p.muted },
        b = { bg = p.surface, fg = p.muted },
        c = { bg = p.surface, fg = p.muted },
    },
}

lualine.setup({
    options = {
        theme = lualine_theme,
        component_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { 'mode', fmt = function(_) return '▎' end }
        },
        lualine_b = {},
        lualine_c = {
            { 'filetype', icon_only = true, },
            { 'filename', path = 1, shorting_target = 50, },
        },
        lualine_x = {
            { word_count },
            'encoding',
            'fileformat',
        },
        lualine_y = {
            'branch',
            'diff',
        },
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
})
