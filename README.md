# SSHFS Bash Script

SSHFS Bash can help you run sshfs faster and connect to the mount target easily.

### Instruction

1. First, please create a .txt file for storing your mount data.  
In this repository, I have already create one sample file for you.

###### Here is some details of each column:

Column Name   | Details
------------- | -------
mount_name    | Mount name of the target, use it in command line
username      | Username for accessing sshfs target
ipaddr        | IP address of sshfs target
folder_name   | Local folder path for you to access the Volume
target_folder | Initial directory when accessing target Volume

2. In ```~/.bash_profile``` or ```~/.bashrc```, **please add the following line for sourcing all .sh file:**  
```for f in /PATH/TO/sshfs-bash/*.sh; do source $f; done```

3. Enjoy to use the sshfs with following commands:

Command | Details
------- | -------
```link <mount_name> start``` | Create the local directory and start mounting the volume.<br>Please make sure you have connected to the same network<br>and the ip address is correct
```link <mount_name> stop``` | Unmount the volume.
```link <mount_name> clear``` | Try to unmount the volume and remove the folder.
```connect <mount_name>``` | Connect to the mount point using ssh.