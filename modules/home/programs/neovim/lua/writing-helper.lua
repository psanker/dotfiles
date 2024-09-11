vim.g.writing_state = false

local function writing_state()
    local state = not vim.g.writing_state

    if state then
        vim.api.nvim_buf_set_keymap(0, 'n', 'j', 'gj', { noremap = true })
        vim.api.nvim_buf_set_keymap(0, 'v', 'j', 'gj', { noremap = true })
        vim.api.nvim_buf_set_keymap(0, 'n', 'k', 'gk', { noremap = true })
        vim.api.nvim_buf_set_keymap(0, 'v', 'k', 'gk', { noremap = true })

        pcall(function() vim.cmd [[ SoftPencil ]] end)
    else
        vim.api.nvim_buf_set_keymap(0, 'n', 'j', 'j', { noremap = true })
        vim.api.nvim_buf_set_keymap(0, 'v', 'j', 'j', { noremap = true })
        vim.api.nvim_buf_set_keymap(0, 'n', 'k', 'k', { noremap = true })
        vim.api.nvim_buf_set_keymap(0, 'v', 'k', 'k', { noremap = true })

        pcall(function() vim.cmd [[ NoPencil ]] end)
    end

    vim.g.writing_state = state
end

vim.api.nvim_create_user_command('RowMovementToggle', writing_state, {})
