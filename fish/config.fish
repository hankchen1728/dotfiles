# Replace `rm` by `rm -i`
alias rm="rm -i"
alias ll="ls -alhF"
alias la="ls -A"

# Add the path of self installed binary
set -U fish_user_paths $HOME/.local/bin $fish_user_paths

# Environment Module
# set ModuleFish "/usr/share/modules/init/fish"
set ModuleFish "$MODULESHOME"/init/fish
if test -f $ModuleFish
    source $ModuleFish
end
