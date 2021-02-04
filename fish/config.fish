# Replace `rm` by `rm -i`
alias rm="rm -i"
alias ll="ls -alhF"
alias la="ls -A"

# Environment Module
set ModuleFish "/usr/share/modules/init/fish"
if test -f $ModuleFish
    source $ModuleFish
end
