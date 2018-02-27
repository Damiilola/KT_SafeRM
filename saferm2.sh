#!/bin/bash
#This is a bash script

home="$HOME"
trashSafermDirName=".Trash_saferm"
trashSafermPath="$home/$trashSafermDirName"
vOption=0
rOption=0
dOption=0

trashSafermFunction(){
    if [ ! -d "$trashSafermPath" ];
    then
        mkdir "$trashSafermPath"
        echo "$trashSafermPath created"
    fi
}

#creating a function for the yes reply
ifUserReplyYes() {
  reply=$1
  if [[ "$reply" == y* || "$reply" == Y* ]]
  then
    true
  else
    false
  fi
}

#creating functions to check if the command line argument is a file or directory
#FOR FILES
actionForFile() {
    read -p "remove $1? " reply
    ifUserReplyYes $reply
    if [[ $? -eq true ]]
    then
      mv $1 $trashSafermPath

      if [[ $vOption -eq 1 ]]
      then
        echo "$1 removed"
      fi
    else
      false
    fi
}

#FOR DIRECTORIES
#functions for action in directories
recursiveProcessForDir() {

  read -p "do you want to examine $1? " reply
  ifUserReplyYes $reply
  #if they want to examine the directory
  if [[ $? -eq true ]]
  then

    if [[ $vOption -eq 1 ]]; then
      echo "you have entered $1"
    fi


    #current directory path is going to be the first argument passed into the function
    currentDirPath=$1
    #this lists the contents of the directory
    dirItemsList=$(ls -l "$currentDirPath" | sort -k1,1 | awk -F " " '{print $NF}' | sed -e '$ d')

    checkIfDirEmpty $currentDirPath

    #if the directory is empty
    if [[ $? -eq true ]]
    then

        actionForFile $currentDirPath

    #if the directory is not empty
    else
      #loop through files in the directory
      for item in $dirItemsList
      do

        #if the current item in the iteration is a file
        if [[ -f "$currentDirPath/$item" ]]
        then
            actionForFile $currentDirPath/$item
        else
          recursiveProcessForDir $currentDirPath/$item
        fi

      done
      #this is to ignore the "." (hidden files) in a directory
      if [ "$currentDirPath"  != "." ]; then
        #delete the parent dir
        actionForFile $currentDirPath
      fi
    fi
    #this gives the directory name of the current directory path
    currentDirPath=$(dirname $currentDirPath)
  fi
}

#this checks for contents in directories

checkIfDirEmpty () {

  dirItemsCount=$(ls -l "$1" | sort -k1,1 | awk -F " " '{print $NF}' | sed -e '$ d' | wc -l | xargs)

  if [[ $dirItemsCount -gt 0 ]]
  then
      false
  else
      true
  fi
}
#==========================================================================================================================================
#implementing the -v(verbose), -r(recursive), -d(remove directories) flags.

trashSafermFunction

while getopts ":vrd" opt; do

  case "$opt" in
    #verbose option
    v)
      #if the v option is being used
      vOption=1
      ;;

    #recursive option
    r)
      #if the r option is being used
      rOption=1
      ;;
    #remove directories option
    d)
      #if the d option is being used
      dOption=1
      ;;
    #if an option that does not exist is provided i.e in this case, an option that is not -v,-r or -d
    \?)
      echo "script usage: incorrect option: "-$1" "
      ;;
  esac
done
#OPTIND is the index of the next argument to be processed (the starting index is 1).
shift "$(($OPTIND -1))"
#if the item in the argument is a file
if [[ -f "$1" ]]
then
    actionForFile $1
fi

#================================================================================================================

#FOR DIRECTORIES
#actual action for directories
currentDir=$1
if [[ -d "$1" ]]
then

  if [[ "$dOption" -eq 1 ]];then

    checkIfDirEmpty $1

    if [[ $? -eq true ]]
    then
      actionForFile $1

    elif [[ "$rOption" -eq 1 ]]; then
      recursiveProcessForDir $1
    else
      echo "$1 is a directory"
      exit
    fi

  fi

  if [[ "$dOption" -eq 0 ]] && [[ "$rOption" -eq 1 ]];
  then
    recursiveProcessForDir $1
  else
    echo "$1 is a directory"
  fi

fi
