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
    return file:gsub('(.*)(/.*)$', '%1')
end

--Get basename of file
---@param file string
---@return string The full basename for the file
local function basename(file)
    return file:gsub('(.*/)(.*)$', '%2')
end

-- Improved linking module + custom commands based on linking
return {
    setup = function()
        local commands = require('zk.commands')
        local api = require('zk.api')

        -- Journaling stuff
        commands.add('ZkDailyEntry', function(_)
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
                    }, function(_, _)
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
}
