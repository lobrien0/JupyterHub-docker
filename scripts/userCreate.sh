#!/bin/bash

#	Program Desc:
# If, while using docker, a container gets destoryed
# or corrupted all user data stored in a persistant 
# volume will be preserved.
#
# This script is designed to recreate the users and
# Remap their data.
#
# Users will loose their previous password.


#------------------
# Checks to see if the password file already exsists
# If it does then it removes the file
FILE="$(pwd)/pswd.data"
if [ -f "${FILE}" ]; then
        rm $FILE
fi

# Runs through all entries in the /home/ direcotry
for dir in /home/*/; do

	#Ex:	"/home/user/"
        x=${dir::-1} # Removes proceading '/' 			|| Ex:	"/home/user"
        y=${x##*/}   # Removes file including and before '/'	|| EX:	"user"

	# Check if user is password file
        if grep -q "${y}" "/etc/passwd"; then
                echo "Password Already Exsists"

	# If not; then will create user and set up everything
        else
                useradd $y
                echo "${y} added"
                echo "$y:Colorado2022" >> $FILE
                echo "File Entry for ${y} made"
                chown -R ${y}:${y} $x
                echo "Directory permissions for ${y} changed"
		echo
		echo
        fi
done

# Checks if password file Exsists; if so, then the script
# will change the password to all users appended in the 
# password file to "Colorado2022"
if [ -f "$FILE" ]; then
	chpasswd < $FILE
	echo "All Passwords Set"
	rm $FILE
fi
