require('rose-pine').setup({
    dark_variant = 'moon',
    highlight_groups = {
        NormalNC = {
            fg = 'subtle',
            bg = 'base',
        },
    },
})

vim.cmd.colorscheme('rose-pine')

local p = require('rose-pine.palette')
local util = require('rose-pine.utilities')

-- Copied from older version of rose-pine
local highlight = function(group, highlight, blend_on)
	local fg = highlight.fg and util.parse_color(highlight.fg) or "NONE"
	local bg = highlight.bg and util.parse_color(highlight.bg) or "NONE"
	local sp = highlight.sp and util.parse_color(highlight.sp) or "NONE"

	if highlight.blend ~= nil and (highlight.blend >= 0 and highlight.blend <= 100) and bg ~= nil then
		bg = util.blend(bg, blend_on or p.base, highlight.blend / 100)
	end

	highlight.fg = fg
	highlight.bg = bg
	highlight.sp = sp

	vim.api.nvim_set_hl(0, group, highlight)
end

local function element_in(el, tab)
    local els_set = {}

    for _, val in ipairs(tab) do
        els_set[val] = true
    end

    return els_set[el] ~= nil
end

local function reg_recording()
    return vim.api.nvim_call_function('reg_recording', {})
end

local function is_recording()
    return reg_recording() ~= ''
end

local function word_count()
    local out = ''

    if element_in(vim.bo.filetype, { 'md', 'markdown', 'txt', 'rmd', 'quarto' }) then
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

local function macro_recording()
    local out = ''

    if is_recording() then
        out = 'recording @' .. reg_recording()
    end

    return out
end

local lualine_theme = {
    normal = {
        a = { bg = p.surface, fg = p.rose },
        b = { bg = p.surface, fg = p.rose },
        c = { bg = p.surface, fg = p.subtle },
        z = { bg = p.rose, fg = p.surface },
    },
    insert = {
        a = { bg = p.surface, fg = p.foam },
        b = { bg = p.surface, fg = p.foam },
        c = { bg = p.surface, fg = p.subtle },
        z = { bg = p.foam, fg = p.surface },
    },
    visual = {
        a = { bg = p.surface, fg = p.iris },
        b = { bg = p.surface, fg = p.iris },
        c = { bg = p.surface, fg = p.subtle },
        z = { bg = p.iris, fg = p.surface },
    },
    replace = {
        a = { bg = p.surface, fg = p.pine },
        b = { bg = p.surface, fg = p.pine },
        c = { bg = p.surface, fg = p.subtle },
        z = { bg = p.pine, fg = p.surface },
    },
    command = {
        a = { bg = p.surface, fg = p.love },
        b = { bg = p.surface, fg = p.love },
        c = { bg = p.surface, fg = p.subtle },
        z = { bg = p.love, fg = p.surface },
    },
    inactive = {
        a = { bg = p.surface, fg = p.muted },
        b = { bg = p.surface, fg = p.muted },
        c = { bg = p.surface, fg = p.muted },
        z = { bg = p.muted, fg = p.surface },
    },
}

local zen_lualine_theme = {
    normal = {
        a = { bg = p.surface, fg = p.rose },
        b = { bg = p.surface, fg = p.rose },
        c = { bg = p.none, fg = p.subtle },
        z = { bg = p.rose, fg = p.surface },
    },
    insert = {
        a = { bg = p.surface, fg = p.foam },
        b = { bg = p.surface, fg = p.foam },
        c = { bg = p.none, fg = p.subtle },
        z = { bg = p.foam, fg = p.surface },
    },
    visual = {
        a = { bg = p.surface, fg = p.iris },
        b = { bg = p.surface, fg = p.iris },
        c = { bg = p.none, fg = p.subtle },
        z = { bg = p.iris, fg = p.surface },
    },
    replace = {
        a = { bg = p.surface, fg = p.pine },
        b = { bg = p.surface, fg = p.pine },
        c = { bg = p.none, fg = p.subtle },
        z = { bg = p.pine, fg = p.surface },
    },
    command = {
        a = { bg = p.surface, fg = p.love },
        b = { bg = p.surface, fg = p.love },
        c = { bg = p.none, fg = p.subtle },
        z = { bg = p.love, fg = p.surface },
    },
    inactive = {
        a = { bg = p.surface, fg = p.muted },
        b = { bg = p.surface, fg = p.muted },
        c = { bg = p.none, fg = p.muted },
        z = { bg = p.muted, fg = p.surface },
    },
}

local custom_highlights = {
    PsaFileModified = { bg = p.surface, fg = p.gold },
}

for k, v in pairs(custom_highlights) do
    highlight(k, v)
end

local function apply_color(highlight_group, content)
    return string.format('%%#%s#%s%%*', highlight_group, content)
end

local std_opts = {
    sections = {
        lualine_a = {
            {
                'mode',
                fmt = function(_) return '▌' end,
                padding = {
                    left = 0,
                    right = 1
                },
            }
        },
        lualine_b = {},
        lualine_c = {
            {
                'filetype',
                icon_only = true,
                fmt = function(str)
                    if vim.g.zen_mode_open then
                        return ''
                    end

                    return str
                end
            },
            {
                'filename',
                path = 1,
                shorting_target = 50,
                symbols = {
                    modified = apply_color('PsaFileModified', '(+)')
                },
            }

        },
        lualine_x = {
            { word_count },
            {
                'encoding',
                fmt = function(str)
                    if vim.g.zen_mode_open then
                        return ''
                    end

                    return str
                end,
            },
        },
        lualine_y = {
            {
                'branch',
                fmt = function(str)
                    if vim.g.zen_mode_open then
                        return ''
                    end

                    return str
                end,
            },
            {
                'diff',
                symbols = { modified = 'Δ' },
                fmt = function(str)
                    if vim.g.zen_mode_open then
                        return ''
                    end

                    return str
                end,
            },
        },
        lualine_z = {
            { macro_recording },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}

---@param zen_mode_active boolean
---@return table
local function lualine_opts(zen_mode_active)
    return vim.tbl_extend(
        'force',
        std_opts,
        {
            options = {
                component_separators = { left = '', right = '' },
                theme = (function()
                    if not zen_mode_active then
                        return lualine_theme
                    else
                        return zen_lualine_theme
                    end
                end)()
            },
        }
    )
end

require('zen-mode').setup({
    window = {
        width = 0.65,
    },
    plugins = {
        gitsigns = { enabled = true };
    },
    on_open = function (_)
        require('lualine').setup(lualine_opts(true))
    end,
    on_close = function ()
        require('lualine').setup(lualine_opts(false))
    end
})

-- Assuming zen-mode is off by default
require('lualine').setup(lualine_opts(false))
