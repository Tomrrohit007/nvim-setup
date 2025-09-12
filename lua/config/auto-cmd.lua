local M = {}

-- Store terminal buffers that should persist
M.terminals = {}

function M.terminal()
  -- Check if we already have a terminal buffer
  for bufnr, _ in pairs(M.terminals) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      -- Check if terminal window is already open
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == bufnr then
          -- Window exists, close it but keep buffer
          vim.api.nvim_win_close(win, false)
          return
        end
      end
      -- Buffer exists but no window, create one
      vim.cmd("vsplit")
      vim.api.nvim_win_set_buf(0, bufnr)
      return
    end
  end

  -- Create new terminal
  vim.cmd("vsplit")
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, bufnr)

  -- Start terminal with shell
  vim.fn.termopen(os.getenv("SHELL") or "bash", {
    on_exit = function(_, code)
      if code == 0 then
        -- Process exited normally, remove from persistent terminals
        M.terminals[bufnr] = nil
      end
      -- For non-zero exits, we keep the buffer for debugging
    end
  })

  -- Mark this terminal as persistent
  M.terminals[bufnr] = true
end

-- Optional: Function to clean up terminated terminals
function M.cleanup_terminals()
  for bufnr, _ in pairs(M.terminals) do
    if not vim.api.nvim_buf_is_valid(bufnr) then
      M.terminals[bufnr] = nil
    end
  end
end

return M
