echo "installing packer"

if [ -d ~/.local/share/nvim/site/pack/packer ]; then
  echo "Clearning previous packer installs"
  rm -rf ~/.local/share/nvim/site/pack
fi

echo "\n=> Installing packer"
git clone https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
echo "=> packer installed!"

nvim +PackerSync

# ======= install LSPs ==========

echo "\n=> Installing pyright"
# pyright for python
npm i -g pyright

echo "\n=> Installing sumneko_lua"
# sumneko_lua for Lua
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive
cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
cd ..
mv ./lua-language-server ${HOME}/.local/
