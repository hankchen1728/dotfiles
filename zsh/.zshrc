# { Configuration } {{{

  # {History} {{{
    # Remove older command from the history if a duplicate is to be added.
    setopt HIST_IGNORE_ALL_DUPS
  # }}}

  # {Input/output} {{{
    # Set editor default keymap to emacs (`-e`) or vi (`-v`)
    bindkey -e

    # Prompt for spelling correction of commands.
    #setopt CORRECT

    # Customize spelling correction prompt.
    #SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

    # Remove path separator from WORDCHARS.
    WORDCHARS=${WORDCHARS//[\/]}
  # }}}

  # { Terminal } {{{
    # if [[ "$TERM" =~ "xterm" ]]; then
    #   export TERM=xterm-256color
    # elif [ "$TERM" = "screen" -o "$TERM" = "screen-256color" ]; then
    #   export TERM=screen-256color
    #   unset TERMCAP
    # fi
  # }}}
  
# }}}

# {ZIM} {{{

  ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

  # Download zimfw plugin manager if missing.
  if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    if (( ${+commands[curl]} )); then
      curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
          https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    else
      mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
          https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    fi
  fi

  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
  if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
    source ${ZIM_HOME}/zimfw.zsh init -q
  fi

  # { Module Configuration } {{{

    # { zsh-autosuggestions } {{{

    # Disable automatic widget re-binding on each precmd. This can be set when
    # zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
    # ZSH_AUTOSUGGEST_MANUAL_REBIND=1

    # Customize the style that the suggestions are shown with.
    # See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
    #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

    # }}}

    # { zsh-syntax-highlighting } {{{

      # Set what highlighters will be used.
      # See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

      # Customize the main highlighter styles.
      # See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
      #typeset -A ZSH_HIGHLIGHT_STYLES
      #ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

    # }}}

  # }}}

  # Initialize modules.
  source ${ZIM_HOME}/init.zsh

  # {Post-init module configuration} {{{

    # { zsh-history-substring-search } {{{

      zmodload -F zsh/terminfo +p:terminfo
      # Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
      for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
      for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
      for key ('k') bindkey -M vicmd ${key} history-substring-search-up
      for key ('j') bindkey -M vicmd ${key} history-substring-search-down
      unset key
    # }}}

  # }}}

# }}}

# { Custom } {{{
  source "${ZSCRIPTDIR}/aliases.zsh"
  source "${ZSCRIPTDIR}/functions.zsh"
# }}}

