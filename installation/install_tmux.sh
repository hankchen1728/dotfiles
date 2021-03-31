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
local_DIR=${HOME}/.local
# export LD_LIBRARY_PRELOAD=${DIR}/lib
PKG_CONFIG_PATH=$local_DIR/lib/pkgconfig:$PKG_CONFIG_PATH ./configure \
    --prefix ${HOME}/.local
    # LIBEVENT_CFLAGS="-I$local_DIR/include" \
    # LIBEVENT_LIBS="-L$local_DIR/lib" \
    # LIBTINFO_CFLAGS="-I$local_DIR/include" \
    # LIBTINFO_LIBS="-L$local_DIR/lib"
make -j 8
make install -j 8

cd .. && rm -rf ${HOME}/tmp/tmux
