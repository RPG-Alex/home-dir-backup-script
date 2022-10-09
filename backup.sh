#!/bin/bash
### Required: ###
# bash
# tar
# gpg
$ pigz (optional but need to modify below if you are not using

#this gets the date, change format to your liking.
DATE=$(date +%Y-%m-%d-%H%M%S)
#put your backup directory here. If its an external don't forget to mount (can modify this script to mount if needed)
BACKUP_DIR=""
#put the full path to your home directory (or whichever directory being backed up here
SOURCE="/home/[username]"


#checks that your backup directory exists
if [ -d $BACKUP_DIR ]
then
	cd "$SOURCE"
  #the exclude peramater will exclude a directory. use quotes and separate by commas for any you don't wanna back up e.g. Downloads
  #pigz is used rather than just tar because its much faster. The output is passed to gpg. It will prompt for a password.  
	tar --exclude={''} -I pigz -cvf - $SOURCE | gpg -c > $BACKUP_DIR/backup-$DATE.tar.gz.gpg
  #for arch only: This will put a package list next to your backup for ease of reinstall (uncomment to add)
	#pacman -Qq > $BACKUP_DIR/$DATE-pkg-list
else
	echo "BACKUP DIRECTORY NOT FOUND"
fi

#decrypt and unzip backup:
##gpg -d folder.tar.gz.gpg | tar -xvzf -
