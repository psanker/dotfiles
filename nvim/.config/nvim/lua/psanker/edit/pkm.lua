local function tbl_length(tbl)
    local len = 0

    for _, _ in pairs(tbl) do
        len = len + 1
    end

    return len
end

--Get dirname of file
---@param file string
---@return string The full dirname for the file
local function dirname(file)
    return file:gsub('(.*)(/.*)$', '%1')[1]
end

--Get basename of file
---@param file string
---@return string The full basename for the file
local function basename(file)
    return file:gsub('(.*/)(.*)$', '%2')[1]
end

-- Improved linking module + custom commands based on linking
return {
    setup = function()
        local commands = require('zk.commands')
        local api = require('zk.api')

        -- Journaling stuff
        commands.add('ZkDailyEntry', function(opts)
            local today = os.date('%Y%m%d')
            local today_human = os.date('%Y-%m-%d')
            local entry_path = 'journal/' .. today .. '.md'

            api.list(nil, { select = { 'path' }, hrefs = { entry_path } }, function(err, res)
                assert(res ~= nil, tostring(err))

                if tbl_length(res) == 0 then
                    api.new(nil, {
                        title = today_human,
                        dir = 'journal',
                        date = 'today',
                        template = 'journal.md'
                    }, function(err, res)
                        assert(res ~= nil, tostring(err))

                        local dir = dirname(res.path)
                        local new_path = dir .. '/' .. basename(entry_path)
                        os.rename(res.path, new_path)

                        vim.cmd('e ' .. new_path)
                    end)
                else
                    vim.cmd('e ' .. res[1]['path'])
                end
            end)
        end)
    end,
    register_commands = function()
        local Remap = require('psanker.keymap')
        local nnoremap = Remap.nnoremap
        local vnoremap = Remap.vnoremap

        nnoremap('<Leader>nn', '<cmd>ZkNew {dir = "notes"}<CR>', { desc = '[n]ew [n]ote' })
        nnoremap('<Leader>nj', '<cmd>ZkDailyEntry<CR>', { desc = '[n]ew [j]ournal entry' })
        nnoremap('<Leader>nm', '<cmd>ZkNew {dir = "notes", template = "meeting.md"}<CR>',
            { desc = '[n]ew [m]eeting note' })

        vnoremap('<Leader>nn', ":'<,'>ZkNewFromTitleSelection {dir = 'notes'}<CR>",
            { desc = '[n]ew [n]ote; title from selected text' })

        vnoremap('<Leader>ni', ":'<,'>ZkNewFromTitleSelection {dir = 'notes', edit = false}<CR>",
            { desc = 'New [n]ote [i]nsert link; title from selected text' })

        nnoremap('<Leader>fn', '<cmd>ZkNotes<CR>')
        vnoremap('<Leader>fn', ":'<,'>ZkMatch<CR>")
        nnoremap('<Leader>ft', '<cmd>ZkTags<CR>')
        nnoremap('<Leader>lb', '<cmd>ZkBacklinks<CR>')
        nnoremap('<Leader>ll', '<cmd>ZkLinks<CR>')
        nnoremap('<Leader>li', "<cmd>ZkInsertLink<CR>")
        vnoremap('<Leader>li', ":'<,'>ZkInsertLinkAtSelection<CR>")
        vnoremap('<Leader>ls', ":'<,'>ZkInsertLinkAtSelection {match = true}<CR>")
    end,
}
