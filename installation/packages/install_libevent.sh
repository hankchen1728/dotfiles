wget https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz

tar zxvf libevent-2.0.22-stable.tar.gz
rm libevent-2.0.22-stable.tar.gz

cd libevent-2.0.22-stable
./configure \
    --prefix=${HOME}/.local \
    --enable-shared
make -j8 && make install -j8

rm -rf libevent-2.0.22-stable
