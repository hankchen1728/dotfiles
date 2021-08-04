git clone https://github.com/Kitware/CMake.git

cd CMake
./bootstrap --prefix=${HOME}/.local
make && make install
