echo "Ormancer Vim Hero Config"
echo "Setup started..."

echo "- installing color schemes"
mkdir -p ~/.vim/colors
cp -r ./colors ~/.vim

echo "Installing plugins"
echo "- installing plugin manager: vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "- installing custom plugins & custom config"
cp ./vim-config ~/.vimrc

#npm i -g jscs

echo "Setup finished ! Do a :PlugInstall vim and let's roll \o/"

