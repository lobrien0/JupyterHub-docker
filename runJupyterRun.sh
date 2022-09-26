#!/bin/bash

# Author Data:
#
#	Author:		Luke O'Brien
#	Updated:	9/25/2020
#
#	Descriotion:
#		Checks if run conditions are met; if not
#		Will attempt to correct before running the
#		JupyterHub Server


# If Volume "jupyter-etc" doesn't exsist, Create it
if [[ "$(docker volume ls)" == *"jupyter-etc"* ]]; then
	echo "ETC Volume exsists; Skipping creation"
else
	docker volume create jupyter-etc
fi


# If Volume "jupyterhub-user" doesn't exsist, Create it
if [[ "$(docker volume ls)" == *"jupyterhub-users"* ]]; then
	echo "USERS Volume exsists; Skipping creation"
else
	docker volume create jupyterhub-users
fi


#starts Docker Continer
docker run -d \
	--name jupyter-hub \
	-p 8000:8000 \
	-v jupyter-etc:/etc/ \
	-v jupyterhub-users:/home/ \
	--restart=unless-stopped \
	lobr266238/jupyterhub-basic

# The above options have the following meaning:
#
# --name jupyter-hub		Names the container jupyter-hub for command id
# -p 8000:8000			Exposed port 8000 on host from port 8000 on container
#					<hostPort>:<containerPort>
#
# -v jupyter:etc/etc/		Mounts volume "jupyter-etc" to /etc/ on container
# -v jupyterhub-users:/home/	Mounts volume "jupyterhub-users" to /home/ on continer
#
# --restart=unless-stopped	On continer interrupt the continer will restart when next
#				able to.
#				Ex) if host computer restart, the container will come back
#				up when the computer turns back on
#
# lobr266238/jupyterhub-basic	Specifies docker image. Will look for image on the computer
#				but if it can't be found it will look on DockerHub and download
#				the latest image before executing it.
