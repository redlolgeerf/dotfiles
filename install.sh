#! /usr/bin/env bash

DOT_PATH="$HOME"/dotfiles
HOMES="$HOME"

function symlink() {
    if [[ -e $2 ]]
        then mv "$2" "$2.old.$RANDOM"
    fi

    echo "Making symlink \"ln -s $1 $2\" "
    ln -s "$1" "$2"
}

function delete() {
    if [[ -e "$1" ]]
        then echo "Removing symlink $1"
        rm "$1"
    fi
}

function install_vim() {
    symlink "$DOT_PATH"/vim "$HOMES"/.vim
    symlink "$DOT_PATH"/vim/.vimrc "$HOMES"/.vimrc
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh
}

function uninstall_vim() {
    delete "$HOMES"/.vim
    delete "$HOMES"/.vimrc
}

function install_zsh() {
    symlink "$DOT_PATH"/zshrc "$HOMES"/.zshrc
}

function uninstall_zsh() {
    delete "$HOMES"/.zshrc
}

function install_devilspie() {
    symlink "$DOT_PATH"/devilspie "$HOMES"/.devilspie
}

function uninstall_devilspie() {
    delete "$HOMES"/.devilspie
}

function install_xresources() {
    symlink "$DOT_PATH"/Xresources "$HOMES"/.Xresources
}

function uninstall_xresouces() {
    delete "$HOMES"/.Xresources
}

function install_awesome() {
    if ! [[ -e "$HOMES"/.config ]]
        then mkdir "$HOMES"/.config
    fi
    symlink "$DOT_PATH"/awesome "$HOMES"/.config/awesome
}

function uninstall_awesome() {
    delete "$HOMES"/.config/awesome
}

function install_tmux() {
    symlink "$DOT_PATH"/tmux.conf "$HOMES"/.tmux.conf
}

function uninstall_tmux() {
    delete "$HOMES"/.tmux.conf
}

INSTALL=true
to_install=()

for i in "$@" ; do
    case $i in
        -u)
            echo "uninstalling"
            INSTALL=false;;
        *)
            to_install+=("$i");;
    esac
done

for p in "${to_install[@]}" ; do
    if $INSTALL
        then install_$p
        else uninstall_$p
    fi
done
