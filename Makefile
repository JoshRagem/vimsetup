.PHONY: install

.vim:
	mkdir .vim

.vim/autoload/plug.vim: .vim
	curl -fLo .vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install: .vim/autoload/plug.vim
	cp -R .vim ~/.vim
	cp .vimrc ~/.vimrc
	vim +PlugInstall +PlugUpdate +qa

clean:
	rm -rf .vim

