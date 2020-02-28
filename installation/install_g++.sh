C_VERSION=${1:-8.2.0}

wget -nc https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz
tar xzf $GCC_VERSION.tar.gz
cd gcc-$GCC_VERSION
./contrib/download_prerequisites

cd ..
mkdir objdir
cd objdir

$PWD/../gcc-$GCC_VERSION/configure \
        --prefix=$HOME/local/GCC-$GCC_VERSION \
            --enable-languages=c,c++,fortran \
                --build=x86_64-linux \
                    --disable-multilib

make -j 16
make -j 8 install

echo "GCC is installed at $HOME/local/GCC-$GCC_VERSION"

