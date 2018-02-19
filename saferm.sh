#!/bin/bash
#This is a bash script.

#create a .Trash_saferm directory

home="$HOME"
trashSafermDirName=".Trash_saferm"
trashSafermPath="$home/$trashSafermDirName"


trashsafermfunction(){
    if [ ! -d "$HOME/.Trash_saferm" ];
    then
        mkdir "$HOME/.Trash_saferm"
        echo "$trashSafeDirName created"
    else
        echo "$trashSafeDirName already exists"
    fi
}

#making if statements for the interactive thing
#first check if it is file or a directory




if [[ -f "$1" ]]
then
    read -p "remove $1? " reply

    if [[ "$reply" == 'y' || "$reply" == 'Y' ]]
    then
        mv $1 $trashSafermPath
        echo "File has been removed"
    else
        echo "File has not been removed"
fi
#
#if [[ -d "$1"]]
#then
#    read -p "remove $1? " reply
#
#    if [[ "$reply" == 'y' || "$reply" == 'Y' ]]
#    then
#        mv $1 $trashSafermPath
#        echo "File has been removed"
#    else
#        echo "File has not been removed"
