
" Set filetypes
augroup Filetypes
  au!
  au BufNewFile,BufRead *.ejs,*.hbs set filetype=html
  au BufNewFile,BufRead .prettierrc,.eslintrc,tsconfig.json set filetype=jsonc
  au BufNewFile,BufRead *.svx,*.mdx,*.md,*.mdp set ft=markdown
augroup END

" Set tabsize for each filetype
augroup Indents
  au!
  au FileType html,xml,css set sw=2 ts=2 sts=2
  au FileType php,javascript,typescript set sw=2 ts=2 sts=2
  au FileType toml,yaml,json set sw=2 ts=2 sts=2
  au FileType c,cpp,go,rust set sw=2 ts=2 sts=2
  au FileType bash,sh,fish,zsh set sw=2 ts=2 sts=2
  au FileType markdown set sw=3 ts=3 sts=3
augroup END
