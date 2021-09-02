# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

zsh_custom=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
# Install 3rd zsh-theme
wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme \
  -P ${zsh_custom}/themes

# Install 3rd functions
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${zsh_custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${zsh_custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-completions \
  ${zsh_custom}/plugins/zsh-completions

git clone https://github.com/RobSis/zsh-completion-generator \
  ${zsh_custom}/plugins/zsh-completion-generator

# install autojump
# brew install autojump
