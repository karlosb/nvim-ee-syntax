" ExpressionEngine template filetype settings

" EE comment format — enables gcc / comment toggling via vim-commentary or similar
setlocal commentstring={!--\ %s\ --}

" Allow : in keyword characters so EE tags like exp:channel:entries
" complete and move as one unit (e.g. with w/b/e motions on tag names)
setlocal iskeyword+=:
