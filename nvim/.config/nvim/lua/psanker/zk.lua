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

                api.link(note.path, location, nil, { title = selected_text }, function(err, foo)
                    if not foo then
                        error(err)
                    end
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
    end,
    register_commands = function()
        local Remap = require('psanker.keymap')
        local nnoremap = Remap.nnoremap
        local vnoremap = Remap.vnoremap

        nnoremap('<M-m>', '<cmd>MarkdownPreviewToggle<CR>')
        nnoremap('<Leader>nn', '<cmd>ZkNew {dir = "refile"}<CR>')
        nnoremap('<Leader>nw', '<cmd>ZkNew {dir = "work"}<CR>')
        nnoremap('<Leader>ng', '<cmd>ZkNew {dir = "general"}<CR>')
        nnoremap('<Leader>nm', '<cmd>ZkNew {dir = "work", template = "meeting.md"}<CR>')
        vnoremap('<Leader>nn', ":'<,'>ZkNewFromTitleSelection {dir = 'refile'}<CR>")
        vnoremap('<Leader>nw', ":'<,'>ZkNewFromTitleSelection {dir = 'work'}<CR>")
        vnoremap('<Leader>ng', ":'<,'>ZkNewFromTitleSelection {dir = 'general'}<CR>")
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
