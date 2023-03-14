#!/bin/bash

#####################################################
# Author Data:                                      #
#                                                   #
#	Author:		Luke O'Brien                        #
#	Updated:	9/25/2022                           #
#                                                   #
#	Descriotion:                                    #
#		Checks if run conditions are met; if not    #
#		Will attempt to correct before running the  #
#		JupyterHub Server                           #
#                                                   #
#####################################################


# Vars' that define container settings
CONF_DATA="jupyter-acct"
USERS_VOLUME="jupyter-users"
CONTAINER_NAME="jupyterhub"
HOST_EXSPOSED_PORT="8000"

#starts Docker Continer
docker run -d \
    --name ${CONTAINER_NAME} \
    -p ${HOST_EXSPOSED_PORT}:8000 \
    -v ${CONF_DATA}: /app/ \
    -v ${USERS_DATA}:/home/ \
    --restart=unless-stopped \
    lobr266238/jupyterhub-basic:latest

#########################################################################################################
# The above options have the following meaning:                                                         #
#                                                                                                       #
# --name jupyter-hub                Names the container jupyter-hub for command id                      #
#                                                                                                       #
# -p $(HOST_EXSPOED_PORT):8000      Exposed port "8000" on host from port 8000 on container             #
#                                   <hostPort>:<containerPort>                                          #
#                                                                                                       #
# -v ${VOLUME}:<container DIR>      Mounts volume <Volume Name> to <container DIR>                      #
#                                                                                                       #
# --restart=unless-stopped          On continer interrupt the continer will restart when next           #
#                                   able to.                                                            #
#                                   Ex) if host computer restart, the container will come back          #
#                                   up when the computer turns back on                                  #
#                                                                                                       #
# lobr266238/jupyterhub-basic       Specifies docker image. Will look for image on the computer         #
#                                   but if it can't be found it will look on DockerHub and download     #
#                                   the latest image before executing it.                               #
#                                                                                                       #
#########################################################################################################