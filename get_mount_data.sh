#!/bin/bash

get_mount_data() {
    # Preset your file directory
  file="/Users/wingchoy/sshfs.txt"
  isMountExist="false"

  # If file path incorrect, send error message
  if [[ ! -f $file ]]; then
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
}
