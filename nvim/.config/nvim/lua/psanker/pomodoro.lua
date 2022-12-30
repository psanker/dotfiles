local lr = require("lualine_require")
local utils = lr.require('lualine.utils.utils')

local M = lr.require('lualine.component'):extend()
M.model = {}

local defaults = {
    work_time = 25,
    break_time = 5,
    wait_time = 1,
}

local periods = {
    WORK = 'work',
    BREAK = 'break',
    WAIT = 'wait',
}

---- Setup Pomodoro timer
---@param options table
function M:init(options)
    M.super.init(self, options)

    self.model.last_tick = nil
    self.model.period = nil

    self.model.work_time = (options.work_time or defaults.work_time) * 60
    self.model.break_time = (options.break_time or defaults.break_time) * 60
    self.model.wait_time = (options.wait_time or defaults.wait_time) * 60
end

function M:start()
    self.model.last_tick = os.time()
    self.model.period = periods.WORK
end

function M:stop()
    if self.model.period ~= nil then
        self.model.period = nil
    end
end

---- Generate lualine string
---@return string
function M:update_status()
    -- Model update
    local current = os.time()
    local dt = os.difftime(current, self.model.last_tick)

    if self.model.period == periods.WORK and dt > self.model.work_time then
        dt = dt - self.model.work_time
        self.model.period = periods.BREAK
        self.model.last_tick = current
    elseif self.model.period == periods.BREAK and dt > self.model.break_time then
        dt = dt - self.model.break_time
        self.model.period = periods.WAIT
        self.model.last_tick = current
    elseif self.model.period == periods.WAIT and dt > self.model.wait_time then
        self:stop()
    end

    -- Draw string
    local out = ''

    if self.model.period ~= nil then
        if self.model.period == periods.BREAK then
            dt = self.model.break_time - dt
            local timer = os.date('%M:%S', dt)

            local hl_color = utils.extract_highlight_colors('ErrorMsg', 'fg')
            local hl = self:create_hl({ fg = hl_color }, 'ErrorMsg')
            out = self:format_hl(hl) .. tostring(timer) .. self:get_default_hl()
        elseif self.model.period == periods.WAIT then
            out = 'Restart Pomodoro?'
        else
            dt = self.model.work_time - dt
            local timer = os.date('%M:%S', dt)

            out = tostring(timer)
        end
    end

    return out
end

-- Register Pomodoro command to begin session
vim.api.nvim_create_user_command("Pomodoro", function()
    M:start()
end, {})

-- Register PomodoroStop command to interrupt session
vim.api.nvim_create_user_command("Pomodoro", function()
    M:stop()
end, {})

return M
