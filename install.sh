#!/usr/bin/env bash

# preset some variables
SRCDIR=$(dirname $0)
FILES=("zshrc" "vimrc" "gitconfig")
# oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    echo "cloning oh-my-zsh"
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

for FILE in ${FILES[@]}; do

    SOURCE="$SRCDIR/$FILE"
    TARGET="$HOME/.$FILE"

    echo "processing $FILE"
    #check if file exists
    if [ -f $TARGET ]; then
        #if they are the same exit loop
        if diff $SOURCE $TARGET > /dev/null ; then
            echo "files are the same - continue"
            continue
        else
            #back up the old one
            echo "backing up $TARGET first"
            cp $TARGET "$TARGET.bck"
        fi
    fi
    # copy file
    echo "copying $SOURCE to $TARGET"
    cp $SOURCE $TARGET
done

echo "finsihed"
