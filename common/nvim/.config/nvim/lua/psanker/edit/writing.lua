local Remap = require("psanker.keymap")

local buf_nnoremap = Remap.buf_nnoremap
local buf_vnoremap = Remap.buf_vnoremap

local set = vim.o

set.spell = true

set.wrap = true
set.linebreak = true

local M = {}

M.setup = function()
    local function toggle_state()
        local state = false

        return function()
            state = not state

            if state then
                buf_nnoremap('j', 'gj')
                buf_vnoremap('j', 'gj')
                buf_nnoremap('k', 'gk')
                buf_vnoremap('k', 'gk')

                pcall(function() vim.cmd[[ TogglePencil ]] end)
            else
                buf_nnoremap('j', 'j')
                buf_vnoremap('j', 'j')
                buf_nnoremap('k', 'k')
                buf_vnoremap('k', 'k')

                pcall(function() vim.cmd[[ TogglePencil ]] end)
            end
        end
    end

    local stateful_func = toggle_state()

    vim.api.nvim_buf_create_user_command(0, 'RowMovementToggle', stateful_func, {})
end

return M
