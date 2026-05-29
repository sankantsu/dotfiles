local previewers = require "telescope.previewers"
local from_entry = require "telescope.from_entry"
local conf = require("telescope.config").values

local ns = vim.api.nvim_create_namespace("")

local M = {}

M.heading_previewer = function()
  local jump_to_line = function (self, bufnr, entry)
    print(self.state.bufname)
    print(vim.inspect(entry))
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    vim.api.nvim_buf_add_highlight(bufnr, ns, "TelescopePreviewLine", entry.lnum-1, 0, -1)
    vim.api.nvim_win_set_cursor(self.state.winid, { entry.lnum, 0 })
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd "norm! zt"
    end)
  end
  return previewers.new_buffer_previewer {
    title = "Heading Preview",
    get_buffer_by_name = function (self, entry)
      return from_entry.path(entry, false)
    end,
    define_preview = function (self, entry)
      local p = from_entry.path(entry, true)
      if p == nil or p == "" then
        return
      end
      conf.buffer_previewer_maker(p, self.state.bufnr, {
        bufname = self.state.bufname,
        winid = self.state.winid,
        callback = function(bufnr)
          jump_to_line(self, bufnr, entry)
        end,
      })
    end,
  }
end

return M
