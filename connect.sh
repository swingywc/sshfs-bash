#!/bin/bash

connect() {
  if [[ $1 == '' ]]; then
    mount_msg 0cfm
  fi

  get_mount_data $1
  ssh $username@$ipaddr
}
