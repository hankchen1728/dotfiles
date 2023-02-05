echo ">>> Installing packer ..."

PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

if [ -d $PACKER_DIR ]; then
  echo ">>> Pulling the lateset packer ..."
  cd $PACKER_DIR
  git pull --depth 1
else
  echo ">>> Downloading the packer ..."
  git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_DIR
fi

echo "=> packer installed!"

nvim +PackerSync


# ======= tree-sitter ===========
# cargo install tree-sitter-cli --git https://github.com/tree-sitter/tree-sitter.git --tag v0.20.0

# ======= install LSPs ==========

echo "\n=> Installing pyright"
# pyright for python
npm i -g pyright

echo "\n=> Installing sumneko_lua"
# sumneko_lua for Lua
git clone --depth 1 https://github.com/LuaLS/lua-language-server.git
cd lua-language-server
git submodule update --depth 1 --init --recursive
cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
cd ..
mv ./lua-language-server ${HOME}/.local/

# echo "\n=> Installing svls"
# cargo install svls
