#!/bin/bash
# This bash script is for running sshfs in a friendly way

link() {

  # If no arguments passed in, send error message together with help message
  if [[ $1 == "" || $2 == "" ]]; then
    mount_msg 0nea
  # If call --help in the command, show help message
  elif [[ $1 == '--help' ]]; then
    mount_msg help
  fi

  get_mount_data $1

  # Action - start
  if [[ $2 == 'start' ]]; then
    printf "\n\rNow creating the folder..."
    mkdir -p $folderpath
    printf "\n\rMounting the ipaddr side..."
    sshfs $username@$ipaddr:$targetpath $folderpath
    mount_msg 1sm $folderpath
  # Action - stop
  elif [[ $2 == 'stop' ]]; then
    printf "\n\rNow umounting..."
    umount -f $folderpath
    mount_msg 1su $1
  # Action - clear
  elif [[ $2 == 'clear' ]]; then
    printf "\n\rNow umounting and delete the directory..."
    umount -f $folderpath
    rm -rf $folderpath
    mount_msg 1cm
  else
    mount_msg 0nsa
  fi
}
