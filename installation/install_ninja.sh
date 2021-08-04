git clone https://github.com/ninja-build/ninja.git

prefix="cmake-build"

cd ninja
cmake -B$prefix -H.
cmake --build $prefix

cp $prefix/ninja ~/.local/bin/
