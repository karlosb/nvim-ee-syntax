# nvim-ee-syntax

Neovim syntax highlighting for [ExpressionEngine 7](https://expressionengine.com/) templates.

EE templates are `.html` files with an embedded tag language. This plugin adds colour
differentiation for all EE-specific constructs so they stand out from the surrounding HTML.

## What gets highlighted

| EE Element | Highlight Group | Colour |
|---|---|---|
| `{!-- comment --}` | `Comment` | Grey italic |
| `{exp:channel:entries ...}` | `Function` | Blue |
| `exp:` prefix | `Special` | Magenta |
| Module name (`channel`, `store`) | `Type` | Cyan |
| Method name (`:entries`, `:cart`) | `Function` | Blue |
| `{/exp:channel:entries}` | `Function` | Blue |
| `{if condition}` / `{/if}` | `Conditional` | Orange/Yellow |
| `{if:elseif ...}` / `{if:else}` | `Conditional` | Orange/Yellow |
| `{layout="_main"}` / `{layout:set ...}` | `Include` | Magenta |
| `{embed="_partials/nav"}` | `Include` | Magenta |
| `{/channel:entries}` (block close) | `Delimiter` | |
| `{segment_1}`, `{title}` | `Identifier` | Green |
| `{embed:param}`, `{image:url}` | `Identifier` | Green |
| `param_name=` inside tags | `Special` | Yellow |
| `"value"` inside tags | `String` | Green |

## Filetype detection

Files are detected as `eehtml` by:

1. **Path** — any `.html` file inside a `*/templates/*/` directory tree (EE's template structure)
2. **Content** — `.html` files whose first 20 lines contain `{exp:`, `{!--`, or `{layout`

## Installation

### lazy.nvim

```lua
{
  "karlbowers/nvim-ee-syntax",
  ft = "eehtml",
}
```

### Local development / testing

```lua
{
  dir = vim.fn.expand("~/.config/nvim/plugins/nvim-ee-syntax"),
  name = "nvim-ee-syntax",
  ft = "eehtml",
}
```

### vim-plug

```vim
Plug 'karlbowers/nvim-ee-syntax'
```

## Filetype plugin extras

- `commentstring` set to `{!-- %s --}` — enables `gcc` comment toggling with
  [vim-commentary](https://github.com/tpope/vim-commentary) or
  [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- `iskeyword` includes `:` so EE tag names move as single units

## Verifying it works

```vim
" Check filetype was detected
:set filetype?
" → filetype=eehtml

" List active syntax groups
:syntax list

" Force the filetype on any buffer
:set ft=eehtml
```

## License

MIT
