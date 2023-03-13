#!/bin/bash

#########################################################
#                                                       #
# Script Only ment to be called by Native Authenticator #
#                                                       #
#########################################################

if [ $# -eq 0 ]; then
    echo "[-] SYSTEM: Please Enter a Username."

elif grep -Fq "$1" /etc/passwd; then
    echo "[~] SYSTEM: User Already Exsists."

else
    useradd -m "$1"
    echo "[+] SYSTEM: The User: $1 was Created."
fi