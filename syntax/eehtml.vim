" Vim syntax file
" Language: ExpressionEngine 7 Templates
" Maintainer: Karl Bowers
" Description: Syntax highlighting for EE template tags embedded in HTML

if exists("b:current_syntax")
  finish
endif

" Load HTML as the base syntax
runtime! syntax/html.vim
unlet! b:current_syntax

" ─── Comments ────────────────────────────────────────────────────────────────
" {!-- EE comment --}  — highest priority, overrides everything inside
syntax region EEComment start="{!--" end="--}" contains=@Spell
      \ containedin=ALLBUT,EEComment

" ─── Module Tags ─────────────────────────────────────────────────────────────
" {exp:channel:entries param="value" param2='value2'}
syntax region EEModuleTag
      \ start="{exp:" end="}"
      \ keepend
      \ contains=EETagPrefix,EEModuleName,EEMethodName,EEParamName,EEParamStr
      \ containedin=ALLBUT,EEComment

syntax match EETagPrefix "exp:" contained
syntax match EEModuleName "\(exp:\)\@<=\w\+" contained
syntax match EEMethodName ":\w\+\ze\([^:{}]\|$\)" contained

" Closing module tags: {/exp:channel:entries}
syntax region EEModuleClose
      \ start="{/exp:" end="}"
      \ keepend
      \ containedin=ALLBUT,EEComment

" ─── Conditionals ────────────────────────────────────────────────────────────
" {if condition}, {if:elseif condition}, {if:else}, {/if}
syntax region EEConditional
      \ start="{if\>" end="}"
      \ keepend
      \ contains=EECondKeyword,EEParamStr,EEParamName
      \ containedin=ALLBUT,EEComment

syntax match EECondKeyword "if\>" contained

syntax region EEElseIf
      \ start="{if:elseif\>" end="}"
      \ keepend
      \ contains=EECondKeyword,EEParamStr,EEParamName
      \ containedin=ALLBUT,EEComment

syntax match EEElseTag "{if:else}"
      \ containedin=ALLBUT,EEComment

syntax match EEEndif "{/if}"
      \ containedin=ALLBUT,EEComment

" ─── Layout Tags ─────────────────────────────────────────────────────────────
" {layout="_main"} {layout:set name="title" value="Home"}  {layout:contents}
syntax region EELayout
      \ start="{layout[=:]" end="}"
      \ keepend
      \ contains=EEParamStr,EEParamName
      \ containedin=ALLBUT,EEComment

" ─── Embed Tags ──────────────────────────────────────────────────────────────
" {embed="_partials/nav" param="value"}
syntax region EEEmbed
      \ start="{embed=" end="}"
      \ keepend
      \ contains=EEParamStr,EEParamName
      \ containedin=ALLBUT,EEComment

" ─── Block Closing Tags ──────────────────────────────────────────────────────
" {/channel:entries} {/items} — excludes {/if} and {/exp:...} (handled above)
syntax match EEBlockClose "{/\(if\>\|exp:\)\@!\w\+\(:\w\+\)*}"
      \ containedin=ALLBUT,EEComment

" ─── Single-param tags ───────────────────────────────────────────────────────
" {switch="val1|val2|val3"}, {redirect="404"}, {parse="inward"}
syntax region EESingleParam
      \ start="{\w\+=['\"]" end="}"
      \ keepend
      \ contains=EEParamStr
      \ containedin=ALLBUT,EEComment

" ─── Non-exp prefixed tags with params ───────────────────────────────────────
" {field:render_label class="..."} — word:word followed by a space (has params)
" Negative lookahead prevents overlap with {exp:...} module tags
syntax region EEPrefixedTag
      \ start="{\(exp:\)\@!\w\+:\w\+\s" end="}"
      \ keepend
      \ contains=EEParamStr,EEParamName
      \ containedin=ALLBUT,EEComment

" ─── Variables ───────────────────────────────────────────────────────────────
" Nested: {embed:var}, {image:url:filename}, {segment_1:raw}
syntax match EENestedVar "{\w\+:\(\w\+:\)*\w\+}"
      \ containedin=ALLBUT,EEComment,EEModuleTag,EEEmbed,EELayout

" Simple (catch-all — defined last, lowest priority)
syntax match EEVariable "{\w\+}"
      \ containedin=ALLBUT,EEComment,EEModuleTag,EEEmbed,EELayout

" ─── Strings and Params (contained) ─────────────────────────────────────────
syntax region EEParamStr start=+"+ end=+"+ contained
syntax region EEParamStr start=+'+ end=+'+ contained
syntax match  EEParamName '\<\w\+=' contained

" ─── Highlight Links ─────────────────────────────────────────────────────────
highlight default link EEComment       Comment
highlight default link EEModuleTag     Function
highlight default link EETagPrefix     Special
highlight default link EEModuleName    Type
highlight default link EEMethodName    Function
highlight default link EEModuleClose   Function
highlight default link EEConditional   Conditional
highlight default link EECondKeyword   Conditional
highlight default link EEElseIf        Conditional
highlight default link EEElseTag       Conditional
highlight default link EEEndif         Conditional
highlight default link EELayout        Include
highlight default link EEEmbed         Include
highlight default link EEBlockClose    Delimiter
highlight default link EESingleParam   Keyword
highlight default link EEPrefixedTag   Function
highlight default link EENestedVar     Identifier
highlight default link EEVariable      Identifier
highlight default link EEParamStr      String
highlight default link EEParamName     Special

let b:current_syntax = "eehtml"
