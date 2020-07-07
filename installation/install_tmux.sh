# tmp folder for installation
if [ ! -d ${HOME}/tmp ]; then
    mkdir ${HOME}/tmp
fi

cd ${HOME}/tmp
# Clone the git repo source code
git clone https://github.com/tmux/tmux.git
cd tmux
bash autogen.sh
# Configuration and Installation
./configure --prefix ${HOME}/.local/
make -j 8

# For bash alias
echo "alias tmux="${HOME}/.local/bin/tmux"" >> ${HOME}/.config/bash/.bashrc
