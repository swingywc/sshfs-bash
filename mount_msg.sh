#!/bin/bash

mount_msg() {
  if [[ $1 == '0nea' ]]; then
    printf "Not enough argument for running sshfs."
  elif [[ $1 == '0fnf' ]]; then
    printf "txt file not found. Please state the filepath at the sshfs bash script."
  elif [[ $1 == '0dnf' ]]; then
    printf "No Mount List found in the txt file. Aborted the mount action."
  elif [[ $1 == '0nsa' ]]; then
    printf "No such action provided."
  elif [[ $1 == '0cfm' ]]; then
    printf "Cannot find mount point information. Aborted the connect action."
  elif [[ $1 == '1sm' ]]; then
    printf "\n\r
            Finish mount! You can start to use it at this directory: $2.
            You can also set domain name in /etc/hosts to speed up your working!"
  elif [[ $1 == '1su' ]]; then
    printf "Finish unmounting! You can restart it again using sshfs $2 start."
  elif [[ $1 == '1cm' ]]; then
    printf "Done clearing!"
  fi

  if [[ $1 == '0nea' || $1 == '0nsa' || $1 == 'help' ]]; then
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
