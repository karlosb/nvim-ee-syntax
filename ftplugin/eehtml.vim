" ExpressionEngine template filetype settings

" EE comment format — enables gcc / comment toggling via vim-commentary or similar
setlocal commentstring={!--\ %s\ --}

" Allow : in keyword characters so EE tags like exp:channel:entries
" complete and move as one unit (e.g. with w/b/e motions on tag names)
setlocal iskeyword+=:

" Stop treesitter — no eehtml parser exists, so treesitter falls back to html
" and treats EE tags as HTML attributes (causing incorrect italic rendering).
" Our Vim regex syntax handles all highlighting for this filetype.
if has('nvim')
  lua vim.treesitter.stop()
endif

" Map Vim's basic HTML syntax groups to treesitter-quality highlight groups
" for this window only. winhighlight is window-local so other HTML files are
" unaffected. Falls back gracefully if a group is not defined by the theme.
if has('nvim')
  lua << EOF
  local maps = {
    { 'htmlTagName', '@tag' },
    { 'htmlArg',     '@attribute' },
    { 'htmlTag',     '@punctuation.bracket' },
    { 'htmlEndTag',  '@punctuation.bracket' },
  }
  -- htmlString: use @string but strip italic so attribute values and plain
  -- text content are not rendered italic even if the theme italicises @string
  local str_hl = vim.api.nvim_get_hl(0, { name = '@string', link = false })
  if str_hl and next(str_hl) then
    str_hl.italic = nil
    str_hl.default = false
    vim.api.nvim_set_hl(0, 'EEHtmlString', str_hl)
    table.insert(maps, { 'htmlString', 'EEHtmlString' })
  end
  local parts = {}
  for _, m in ipairs(maps) do
    local hl = vim.api.nvim_get_hl(0, { name = m[2], link = false })
    if hl and next(hl) then
      table.insert(parts, m[1] .. ':' .. m[2])
    end
  end
  if #parts > 0 then
    vim.opt_local.winhighlight:append(table.concat(parts, ','))
  end
EOF
endif
