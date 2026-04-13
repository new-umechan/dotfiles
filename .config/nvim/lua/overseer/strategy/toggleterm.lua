local shell = require("overseer.shell")
local util = require("overseer.util")
local JobstartStrategy = require("overseer.strategy.jobstart")

---@class overseer.ToggletermStrategy : overseer.Strategy
---@field opts table
---@field fallback overseer.Strategy|nil
---@field term table|nil
---@field bufnr integer|nil
local ToggletermStrategy = {}

---@param opts table|nil
---@return overseer.Strategy
function ToggletermStrategy.new(opts)
    opts = vim.tbl_extend("keep", opts or {}, {
        direction = "vertical",
        close_on_exit = false,
        auto_scroll = true,
        open_on_start = true,
        preserve_output = false,
    })

    local strategy = {
        opts = opts,
        fallback = nil,
        term = nil,
        bufnr = nil,
    }
    setmetatable(strategy, { __index = ToggletermStrategy })

    local ok = pcall(require, "toggleterm.terminal")
    if not ok then
        strategy.fallback = JobstartStrategy.new({
            use_terminal = true,
            preserve_output = opts.preserve_output,
        })
    end

    ---@type overseer.ToggletermStrategy
    return strategy
end

function ToggletermStrategy:reset()
    if self.fallback then
        self.fallback:reset()
        return
    end

    if self.term and self.term.job_id and self.term.job_id > 0 then
        vim.fn.jobstop(self.term.job_id)
    end

    if not self.opts.preserve_output and self.term then
        self.term:shutdown()
        self.term = nil
        self.bufnr = nil
    end
end

function ToggletermStrategy:get_bufnr()
    if self.fallback then
        return self.fallback:get_bufnr()
    end
    return self.bufnr
end

---@param task overseer.Task
function ToggletermStrategy:start(task)
    if self.fallback then
        self.fallback:start(task)
        return
    end

    local terminal = require("toggleterm.terminal").Terminal
    local stdout_iter = util.get_stdout_line_iter()

    self.term = terminal:new({
        direction = self.opts.direction,
        close_on_exit = self.opts.close_on_exit,
        auto_scroll = self.opts.auto_scroll,
        dir = task.cwd,
        env = task.env,
        on_stdout = function(_, _, data)
            if not data or vim.tbl_isempty(data) then
                return
            end
            task:dispatch("on_output", data)
            local lines = stdout_iter(data)
            if not vim.tbl_isempty(lines) then
                task:dispatch("on_output_lines", lines)
            end
        end,
        on_stderr = function(_, _, data)
            if not data or vim.tbl_isempty(data) then
                return
            end
            task:dispatch("on_output", data)
            local lines = stdout_iter(data)
            if not vim.tbl_isempty(lines) then
                task:dispatch("on_output_lines", lines)
            end
        end,
        on_exit = function(_, _, exit_code)
            if vim.v.exiting == vim.NIL then
                ---@diagnostic disable-next-line: invisible
                task:on_exit(exit_code or 0)
            end
        end,
    })

    if self.opts.open_on_start then
        self.term:open(self.opts.size, self.opts.direction)
    else
        self.term:spawn()
    end

    self.bufnr = self.term.bufnr

    local command = task.cmd
    if type(command) == "table" then
        command = shell.escape_cmd(command)
    end
    self.term:send(string.format("%s; exit $?", command), false)
end

function ToggletermStrategy:stop()
    if self.fallback then
        self.fallback:stop()
        return
    end
    if self.term and self.term.job_id and self.term.job_id > 0 then
        vim.fn.jobstop(self.term.job_id)
    end
end

function ToggletermStrategy:dispose()
    if self.fallback then
        self.fallback:dispose()
        return
    end
    self:stop()
    if self.term then
        self.term:shutdown()
        self.term = nil
    end
    self.bufnr = nil
end

return ToggletermStrategy
