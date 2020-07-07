install_dir=${1:-"${HOME}/.local/"}

# Clone the git repository
git clone https://github.com/fish-shell/fish-shell.git

# Cd into the git directory
cd ./fish-shell

# make and install
cmake . \
    -DCMAKE_INSTALL_PREFIX=$install_dir;
make -j 8;
make install -j 8;

# Remove the git respository
cd ..
rm -rf ./fish-shell
