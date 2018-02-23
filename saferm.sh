#!/bin/bash
#This is a bash script.

#create a .Trash_saferm directory

home="$HOME"
trashSafermDirName=".Trash_saferm"
trashSafermPath="$home/$trashSafermDirName"
currentItem=$1


trashsafermfunction(){
    if [ ! -d "$HOME/.Trash_saferm" ];
    then
        mkdir "$HOME/.Trash_saferm"
        echo "$trashSafeDirName created"
    else
        echo "$trashSafeDirName already exists"
    fi
}


#recursivelycheckingdirectory(){
#    for files in "$1"/*
#    do
#        read "Do you want to delete "$1"/* ? " reply
#        if [[ "$reply" == 'y' || "$reply" == 'Y' ]]
#        then
#
#    #if the next item is a subdirectory
#    elif [[ ]


#making if statements for the interactive thing
#first check if it is file or a directory
#FOR FILES

ifUserReplyYesFiles() {
  reply=$1

  if [[ "$reply" == y* || "$reply" == Y* ]]
  then
    mv $2 $trashSafermPath
    #kind of implementing the -v option by calling the name of the file and displaying that it has been deleted
    echo "$2 has been removed"
  else
    echo "$2 has not been removed"
  fi

}

if [[ -f "$1" ]]
then
    read -p "remove $1? " reply
    filename=$1
    ifUserReplyYesFiles $reply $filename

fi

#FOR DIRECTORIES

#$1=first command line argument (in this case representing a DIRECTORY)
# currentItemInDir=$item
# currentItemInDirPath=$1/$currentItemInDir

dirItemsCount=$(ls -l "$1" | sort -k1,1 | awk -F " " '{print $NF}' | sed -e '$ d' | wc -l | xargs)
dirItemsList=$(ls -l "$1" | sort -k1,1 | awk -F " " '{print $NF}' | sed -e '$ d')

recursiveProcessForFilesInDir() {
  #loop through files in the directory
  for item in $dirItemsList
  do
    #if the current item in the iteration is a file
    if [[ -f "$1/$item" ]]
    then
        read -p "remove $1/$item? " reply
          if [[ "$reply" == y* || "$reply" == Y* ]]
          then
              mv $currentItemInDirPath $trashSafermPath
          else
              echo "File not removed"
          fi
    done
}

recursiveProcessInDir() {
  #loop through files in the directory
  for item in $dirItemsList
  do
    #if the current item in the iteration is a file
    if [[ -f "$1/$item" ]]
    then
        read -p "remove $1/$item? " reply
          if [[ "$reply" == y* || "$reply" == Y* ]]
          then
            # echo "$1/$item removed"
              mv $currentItemInDirPath $trashSafermPath
          else
              echo "File not removed"
    #if the current item in the iteration is a directory (sub directory),
    elif [[ -d "$1/$item" ]]
    then
        read -p "examine contents in $1/$item? " reply
            if [[ "$reply" == y* || "$reply" == Y* ]]
            then
                currItem=$1/$item
                presentDir=$currentItem/$currItem
                read -p "examine contents in $presentDir?" reply
                  if [[ "$reply" == y* || "$reply" == Y* ]]
                  then
                    recursiveProcessForFilesInDir $presentDir



          fi
}

#checking the contents in the DIRECTORY
checkForDirs () {
  if [[ $dirItemsCount -gt 0 ]]
  then
      echo "Directory not empty"
      read -p "Examine contents in $1? " reply


}

if [[ -d "$1" ]]
then














                                cdir=$1/$item


                                  if [[ "$reply" == y* || "$reply" == Y* ]]
                                  then
                                      echo "$cdir examined"
                                  fi

                              fi
                      fi          # mv $thing $trashSafermPath
                    done
                fi
        fi
fi

              #ask whether to delete the file in the iteration
              # read -p "Do you want to delete $thing?" reply
              #
              # if [[ "$reply" == y* || "$reply" == Y* ]]
              # then
              #
              #
              #
              #   fi
              #
              #     mv $currentItemInDirPath $trashSafermPath
              # else
              #     echo "File or Directory not removed"
              #
              #     #check if the directory is empty.
              #     if [[ $dirItemsCount -eq 0 ]]
              #     then
              #         echo "Directory is empty"
              #         #move the directory to trash saferm
              #         mv $1 $trashSafermPath
              #     fi
              #
              # fi
#               done
#           fi
#     #if the reply is anything other than y*, go back to the parent directory (..)
#     else
#         cd ..
#     fi
# fi



# handleSubDirs () {
#   for thing in $dirItemsList
#   do
#     #ask whether to delete the current file in the iteration
#     read -p "Do you want to delete $thing?" reply
#
#       if [[ "$reply" == y* || "$reply" == Y* ]]
#       then
#           mv $1/$thing $trashSafermPath
#
#
#
# }

# if [[ -d "$1" ]]
# then
#     dirItemsCount=$(ls -l "$1" | sort -k1,1 | awk -F " " '{print $NF}' | sed -e '$ d' | wc -l | xargs)
#     dirItemsList=$(ls -l "$1" | sort -k1,1 | awk -F " " '{print $NF}' | sed -e '$ d')
#     read -p "Do you want to examine the $1? " reply
#
#     if [[ "$reply" == y* || "$reply" == Y* ]]
#     then
#         #check the contents of the directory before removing
#         if [[ $recursiveCheck -eq 0 ]]
#         then
#             echo "Directory empty"
#             #move the directory to .trash
#             mv $itemPath $trashSafermPath
#             echo "Directory has been removed"
#
#             #if the contents of the directory is greater than 0
#         elif [ $recursiveCheck -gt 0 ]
#         then
#             echo "$1 directory not empty!"
#             for thing in "$recursiveCheckList/$currentDir"
#             {
#                 echo "$thing"
#                 read -p "Do you want to remove $thing?" reply
#                     if [[ "$reply" == y* || "$reply" == Y* ]]
#                     then
#                         mv $thing $trashSafermPath
#                         echo "$thing has been removed"
#                     fi
#             }
#
#         fi
#     fi
# fi
#
