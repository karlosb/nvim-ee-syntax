-- ExpressionEngine template filetype detection
-- EE stores templates as .html files inside named template groups

-- Path-based detection: any .html inside a templates/ directory tree
vim.filetype.add({
  pattern = {
    [".*[/\\]templates[/\\].*[/\\].*%.html"] = "eehtml",
  },
})

-- Content-based fallback: .html files with EE-specific markers
-- Lower priority (-1) so path-based wins when both match
vim.filetype.add({
  pattern = {
    [".*%.html"] = {
      function(path, bufnr)
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 20, false)
        for _, line in ipairs(lines) do
          if line:match("{exp:") or line:match("{!%-%-") or line:match("{layout") then
            return "eehtml"
          end
        end
      end,
      { priority = -1 },
    },
  },
})
