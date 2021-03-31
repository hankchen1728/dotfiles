wget http://ftp.gnu.org/gnu/bison/bison-3.7.6.tar.gz

tar zxvf bison-3.7.6.tar.gz
rm bison-3.7.6.tar.gz

cd bison-3.7.6
./configure --prefix=${HOME}/.local
make -j8 && make install -j8

cd .. && rm -rf bison-3.7.6
