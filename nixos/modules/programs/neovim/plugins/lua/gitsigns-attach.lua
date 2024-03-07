function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, { expr = true, desc = "git: go to next [c]hunk" })

    map('n', '[c', function()
        if vim.wo.diff then return '[h' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, { expr = true, desc = "git: go to previous [c]hunk" })

    -- Commands
    map('n', '<leader>ghs', gs.stage_hunk, { desc = "[g]it: [s]tage [h]unk" })
    map('n', '<leader>ghr', gs.reset_hunk, { desc = "[g]it: [r]eset [h]unk" })
    map('v', '<leader>ghs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
        { desc = "[g]it: [s]tage [h]unk" })
    map('v', '<leader>ghr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
        { desc = "[g]it: [r]eset [h]unk" })
    map('n', '<leader>ghS', gs.stage_buffer, { desc = "[g]it: [s]tage [B]uffer" })
    map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = "[g]it: [u]ndo stage [h]unk" })
    map('n', '<leader>ghR', gs.reset_buffer, { desc = "[g]it: [r]eset [B]uffer" })
    map('n', '<leader>ghp', gs.preview_hunk, { desc = "[g]it: [p]review [h]unk" })
    map('n', '<leader>gbl', function() gs.blame_line { full = true } end,
        { desc = "[g]it: view [b]lame for [l]ine" })
    map('n', '<leader>gtb', gs.toggle_current_line_blame,
        { desc = "[g]it: [t]oggle line [b]lame" })
    map('n', '<leader>ghd', gs.diffthis, { desc = "[g]it: [d]iff this [h]unk against index" })
    map('n', '<leader>ghD', function() gs.diffthis('~') end,
        { desc = "[g]it: [D]iff this [h]unk against previous commit" })
    map('n', '<leader>gtd', gs.toggle_deleted, { desc = "[g]it: [t]oggle [d]eleted lines" })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end
