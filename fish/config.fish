# Replace `rm` by `rm -i`
alias rm="rm -i"
alias ll="ls -alhF"
alias la="ls -A"
# alias nvim="~/.local/bin/nvim"

# Environment Module
# set ModuleFish "/usr/share/modules/init/fish"
set ModuleFish "$MODULESHOME"/init/fish
if test -f $ModuleFish
    source $ModuleFish
end
