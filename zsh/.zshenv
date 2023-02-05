### DIRECTORIES
export ZDOTDIR="$HOME/.config/zsh"
export ZSCRIPTDIR="$ZDOTDIR/zsh"

# { System Variables } {{{

  # { System } {{{
    export BREW_PREFIX="/opt/homebrew"  # or call $(brew --prefix)
    export VISUAL="$BREW_PREFIX/bin/nvim"
    export EDITOR="$VISUAL"
    export TERMINAL="alacritty"
  # }}}

  # { nvm } {{{
    export NVM_DIR="$HOME/.nvm"
    [ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$BREW_PREFIX/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  # }}}

  # { Python } {{{
    export PATH="$HOME/Library/Python/3.9/bin:$PATH"
  # }}}

  # { Rust } {{{
    . "$HOME/.cargo/env"
    export RUST_LOG=info
  # }}}

  # { PATH } {{{
    export PATH="$HOME/.local/bin:$PATH"
  # }}}

# }}}
