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
