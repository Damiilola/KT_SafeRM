#!/bin/bash
#This is a bash script

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

#creating a function for the yes reply
ifUserReplyYes() {

  if [[ "$reply" == y* || "$reply" == Y* ]]
  then
      echo ""
  else
      echo "Action not performed"
  fi
}

#creating functions to check if the command line argument is a file or directory
#FOR FILES
actionForFiles() {
    read -p "remove $1?" reply
    reply=$reply
    ifUserReplyYes $reply
    filename=$1
    mv $filename $trashSafermPath
}
#FILES ARE WORKING WELL NOW DO NOT TOUCH!!!!!!
#if the item in the argument is a file
if [[ -f "$1" ]]
then
    item=$1
    actionForFiles $item
fi

#================================================================================================================

#FOR DIRECTORIES

recursiveProcessForDir() {
  currentItem=$item
  currentDir=$1
  currentDirPath=$currentDir/$currentItem
  #this checks if the number of items in a directory
  dirItemsCount=$(ls -l "$1" | sort -k1,1 | awk -F " " '{print $NF}' | sed -e '$ d' | wc -l | xargs)
  #this lists the contents of the directory
  dirItemsList=$(ls -l "$1" | sort -k1,1 | awk -F " " '{print $NF}' | sed -e '$ d')

      #loop through files in the directory
      for item in $dirItemsList
      do
        #if the current item in the iteration is a file
        if [[ -f "$currentItem" ]]
        then
            currentItem=$item
            actionForFiles $currentItem
        fi
          if [[ -d "$currentItem" ]]
          then
              read -p "do you want to examine $currentDirPath?" reply
              ifUserReplyYes $reply
              echo "hi"
              checkDirStatus $currentDir
              #the present working item becomes the path of the particular item (file or directory) in the iteration
              # presentWorkingItem=$currentDirPath/$currentItem
              # read -p "examine the contents of "$presentWorkingItem"? " reply


          fi
      done
}

#this checks for contents in directories

checkDirStatus () {
  if [[ $dirItemsCount -gt 0 ]]
  then
      currentItem=$item
      currentDir=$1
      currentDirPath=$currentDir/$currentItem
      echo "directory has contents"
  fi
      if [[ $dirItemsCount -eq 0 ]]
      then
          echo "Directory empty"
          read -p "Do you want to remove directory?" reply
          if [[ "$reply" == y* || "$reply" == Y* ]]
          then
              mv $1 $trashSafermPath
              echo "directory removed"
          fi
      fi
}






#FOR DIRECTORIES

if [[ -d "$1" ]]
then
    read -p "Do you want to examine "$1"? " reply
    currentDir=$1
    ifUserReplyYes $reply
    item=$item
    currentDir=$1
    currentDirPath=$currentDir/$item
    # checkDirStatus $currentDir
    recursiveProcessForDir $currentDir
fi
