VERSION=${1:-"2.27"}
wget http://ftp.gnu.org/gnu/glibc/glibc-$VERSION.tar.gz

tar zxvf glibc-$VERSION.tar.gz
rm glibc-$VERSION

cd glibc-$VERSION
mkdir build && cd build && ../configure --prefix=${HOME}/.local && make -j8 && make install
    # --disable-profile \
    # --enable-add-ons \
    # --with-headers=${HOME}/.local/include \
    # --with-binutils=${HOME}/.local/bin
# make -j8 && make install

cd .. && rm -rf glibc-$VERSION
