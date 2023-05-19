## Cheatsheet

### REPL

    rlwrap idris2

    :l "file.idr"   -- :load
    :r              -- :reload

    :ac <line> <func>           -- :addclause
    :cs <line> <col> <term>     -- :casesplit
    :ps <line> <hole>           -- :proofsearch
    :psnext
    :gd <line> <func>           -- try generate
    :gdnext
    :ml <line> <hole>           -- :makelemma

### VIM

- https://github.com/edwinb/idris2-vim

  \a " :addclause
  \c " :casesplit
  \s " :proofsearch
  \l " :makelemma

### VS Code

- https://github.com/bamboo/idris2-lsp-vscode

Save then use `ctrl + .`
