#!/bin/sh

clean(){
    find . -regex ".*~" | xargs rm -rf
}

install(){
    echo hello
}

push_git(){
    #clean
    echo * 
    #git add *
}

[ $1 = clean ] && clean
[ $1 = git ] && push_git
