local function tbl_length(tbl)
    local len = 0

    for _, _ in pairs(tbl) do
        len = len + 1
    end

    return len
end

--Get dirname of file
--@param file string
--@return string The full dirname for the file
local function dirname(file)
    return file:gsub('(.*)(/.*)$', '%1')
end

--Get basename of file
--@param file string
--@return string The full basename for the file
local function basename(file)
    return file:gsub('(.*/)(.*)$', '%2')
end

-- Improved linking module + custom commands based on linking
return {
    setup = function()
        local commands = require('zk.commands')
        local util = require('zk.util')
        local zk = require('zk')
        local api = require('zk.api')

        local function fix_cursor_location(location)
            -- Cursor LSP position is a little weird.
            -- It inserts one line down. Seems like an off by one error somewhere
            local pos = location['range']['start']

            pos['line'] = pos['line'] - 1
            pos['character'] = pos['character'] + 1

            location['range']['start'] = pos
            location['range']['end'] = pos

            return location
        end

        commands.add('ZkLinkFromSelectedText', function(opts)
            opts = opts or {}
            local location = util.get_lsp_location_from_selection()
            local selected_text = util.get_text_in_range(util.get_selected_range())

            assert(selected_text ~= nil, "No selected text")

            if opts['match'] then
                opts = vim.tbl_extend("force", { match = { selected_text } }, opts or {})
            end

            zk.pick_notes(opts, { multi_select = false }, function(note)
                assert(note ~= nil, "Something screwy happened")

                api.link(note.path, location, nil, { title = selected_text },
                    function(err, foo) if not foo then error(err) end
                    end)
            end)
        end, { needs_selection = true })

        commands.add('ZkLinkFromSearchedText', function(opts)
            local location = fix_cursor_location(util.get_lsp_location_from_caret())
            local search_term = vim.fn.input('Search > ')

            if search_term == '' then return end

            opts = vim.tbl_extend("force", { match = { search_term } }, opts or {})

            zk.pick_notes(opts, { multi_select = false }, function(note)
                assert(note ~= nil, "Something screwy happened")

                api.link(note.path, location, nil, {}, function(err, foo)
                    if not foo then
                        error(err)
                    end
                end)
            end)
        end, { needs_selection = false })

        commands.add('ZkInsertLink', function(opts)
            local location = fix_cursor_location(util.get_lsp_location_from_caret())

            opts = vim.tbl_extend("force", {}, opts or {})

            zk.pick_notes(opts, { multi_select = false }, function(note)
                assert(note ~= nil, "Something screwy happened")

                api.link(note.path, location, nil, {}, function(err, foo)
                    if not foo then
                        error(err)
                    end
                end)
            end)
        end, { needs_selection = false })

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

        nnoremap('<M-m>', '<cmd>MarkdownPreviewToggle<CR>')

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
        vnoremap('<Leader>li', ":'<,'>ZkLinkFromSelectedText<CR>")
        nnoremap('<Leader>ls', "<cmd>ZkLinkFromSearchedText<CR>")
        vnoremap('<Leader>ls', ":'<,'>ZkLinkFromSelectedText {match = true}<CR>")
    end,
}
