#!/bin/bash
# This bash script is for running sshfs in a friendly way
mount() {

  # Preset your file directory
  file="/Users/wingchoy/sshfs.txt"
  isMountExist="false"

  # If no arguments passed in, send error message together with help message
  if [[ $1 == "" || $2 == "" ]]; then
    mount_msg 0nea
  # If call --help in the command, show help message
  elif [[ $1 == '--help' ]]; then
    mount_msg help
  # If file path incorrect, send error message
  elif [[ ! -f $file ]]; then
    mount_msg 0fnf
  fi

  # For-loop and get the specific mount data
  while IFS='' read -r line; do
    array=($line)
    if [[ $1 == ${array[0]} ]]; then
      username="${array[1]}"
      ipaddr="${array[2]}"
      folderpath="${array[3]}"
      targetpath="${array[4]}"
      isMountExist="true"
    fi
  done <"$file"

  # If cannot find the mount in the list, send error message
  if [[ $isMountExist == "false" ]]; then
    mount_msg 0dnf
  fi

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
  fi
}

mount_msg() {
  if [[ $1 == '0nea' ]]; then
    printf "Not enough argument for running sshfs."
  elif [[ $1 == '0fnf' ]]; then
    printf "txt file not found. Please state the filepath at the sshfs bash script."
  elif [[ $1 == '0dnf' ]]; then
    printf "No Mount List found in the txt file. Aborted the mount action."
  elif [[ $1 == '1sm' ]]; then
    printf "\n\r
            Finish mount! You can start to use it at this directory: $2.
            You can also set domain name in /etc/hosts to speed up your working!"
  elif [[ $1 == '1su' ]]; then
    printf "Finish unmounting! You can restart it again using sshfs $2 start."
  elif [[ $1 == '1cm' ]]; then
    printf "Done clearing!"
  fi

  if [[ $1 == '0nea' || $1 == 'help' ]]; then
    printf "\n\r
            Usage: mount <mount name> <action>

            <mount name> is set by user in the txt file's list.

            <action>:\n\r
            --help   quick help of this command
            start    start the mount by adding the directory folder and run sshfs
            stop     only stop the sshfs connection to the mount point
            clear    stop the sshfs connection and remove the mount folder in local

            For your information, this is just a bash script that auto run the sshfs command.
            Please install sshfs in your OS. Installation method can be found in sshfs github page.
            https://github.com/libfuse/sshfs"
  fi
  kill -INT $$
}
