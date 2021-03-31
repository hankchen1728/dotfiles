wget https://ftp.gnu.org/gnu/ncurses/ncurses-6.2.tar.gz

tar zxvf ncurses-6.2.tar.gz
rm ncurses-6.2.tar.gz

cd ncurses-6.2
./configure --prefix=${HOME}/.local \
    --with-shared \
    --with-termlib \
    --enable-pc-files \
    --with-pkg-config-libdir=${HOME}/.local/lib/pkgconfig

make -j8 && make install -j8

# remove the source code
cd .. && rm -rf ncurses-6.2
