#!/bin/bash

#############################################################
# Program Data:                                             #
#                                                           #
#   Author: Luke O'Brien                                    #
#   Updated: 3/13/2023                                      #
#   Run as SU?: YES (Read Note Below)                       #
#                                                           #
#   Description:                                            #
#       Simply program for user creation with error         #
#       checking and logging.                               #
#                                                           #
#   Echo for logging?:                                      #
#       Echo is being used for logging as this script is    #
#       designed to run inside a docker container, so all   #
#       logs get thrown to sys-out                          #
#       Then logs can be read by doing:                     #
#       `docker logs <container>` on the host machine       #
#                                                           #
#############################################################

#############################################################
#                                                           #
# Note:                                                     #
# Script is ONLY ment to be called by Native Authenticator  #
#                                                           #
#############################################################

# Checks if an input was given, if not, then error thrown
if [ $# -eq 0 ]; then
    echo "[-] SYSTEM: Please Enter a Username."

# Checks if User alread exsists in Unix system
elif grep -Fq "$1" /etc/passwd; then
    echo "[~] SYSTEM: User Already Exsists."

# If the above errors are not found, user is created
# with a home directory
else
    useradd -m "$1"
    echo "[+] SYSTEM: The User: $1 was Created."
fi