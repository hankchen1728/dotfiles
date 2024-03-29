# { common } {{{
  alias v='nvim'
  alias h='history'
  alias tm='tmux attach || tmux'
# }}}

# { list } {{{
  alias l='ls -lCah'
  alias la='ls -lAh'
  alias ll='ls -lh'
  alias lt='ls -rlath'
  alias ls='ls --color=tty'
  alias lsa='ls -lah'
  alias lx='ls -Xlh'
  alias statperm='stat -f "%OLp" '  # Octal Mode
# }}}

# {remove} {{{
  alias rm='rm -i'
  alias rf='rm -f'
# }}}

# { Python } {{{
  alias p='python'
  alias p2='python2'
  alias p3='python3'
  alias ipy='ipython'
  alias ipy3='ipython3'
# }}}

CFG_PATH="$HOME/.config"
# { Configuration } {{{
  alias cd-cfg='cd $CFG_PATH'
  alias cfg-bash='$EDITOR ${CFG_PATH}/sh/.bashrc'
  alias cfg-zsh='$EDITOR ${CFG_PATH}/sh/.zshrc'
  alias cfg-tmux='$EDITOR ${CFG_PATH}/tmux/.tmux.conf'
  alias cfg-fish='$EDITOR ${CFG_PATH}/fish/config.fish'
  alias cfg-vim='$EDITOR ${CFG_PATH}/vim/.vimrc'
  alias cfg-nvim='$EDITOR ${CFG_PATH}/nvim/init.vim'
  alias cfg-terminal='$EDITOR ${CFG_PATH}/alacritty/alacritty.yml'
# }}}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
