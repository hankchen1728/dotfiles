if [ ! -d ${HOME}/tmp ]; then
    mkdir ${HOME}/tmp
fi

read -p "What python version do you want? [Default: 3.6.4] " pyversion
# moduleversion=${moduleversion:-'[file tail $ModulesCurrentModulefile]'}
PYVERSION=${pyversion:-'3.6.4'}

# Install the following tools
# sudo apt install -y wget curl #
cd ${HOME}/tmp
if [ ! -f Python-${PYVERSION}.tgz ]; then
    curl -OL https://www.python.org/ftp/python/${PYVERSION}/Python-${PYVERSION}.tgz
fi
if [ ! -d Python-${PYVERSION} ]; then
    tar -zxvf Python-${PYVERSION}.tgz
fi

# Make sure the following tools are installed before compiling
# sudo apt-get install -y make build-essential libssl-dev \
#     zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
#     llvm libncurses5-dev  libncursesw5-dev xz-utils tk-dev

cd Python-${PYVERSION}/
./configure --prefix=${HOME}/local/modules/Cellar/python3/${PYVERSION}/ \
    --enable-optimizations \
    --disable-option-checking \
    --with-ssl \
    --with-ensurepip

make -j16
make -j16 install

#PYTHON=${HOME}/local/modules/Cellar/python3/${PYVERSION}/bin/python3
#$PYTHON -m ensurepip

cd ${HOME}

