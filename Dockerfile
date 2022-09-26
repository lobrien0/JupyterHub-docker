# DockerFile

# ----- ----- ----- ----- -----
# Using the base image of Ubuntu
FROM ubuntu
ARG jupyterlocal

# Runs all commands bellow under root
USER root

# General Updates and Dependency Installs
RUN apt-get update
RUN apt-get install -yq --no-install-recommends \
	ca-certificates \
	locales \
	python3 \
	python3-pip \
	nodejs \
	npm \
	pandoc \
	texlive-xetex \
	texlive-fonts-recommended \
	texlive-plain-generic

# Installs the JupyterHub server along with the JupyterLab Dependency
# Docker Spawner allows us to generate a lab while running in a docker container
RUN mkdir -p /apps/jupyter
WORKDIR /apps/jupyter
RUN python3 -m pip install jupyterhub
RUN python3 -m pip install jupyterlab 

# NPM install, Mangages all the Web handlers to provide a webpage over select ports
RUN npm install -g configurable-http-proxy

# The port that needs to be exposed to the host system 
# Port 8000 is what the server listens on
EXPOSE 8000

# Runs the container with this command as primary process
CMD ["jupyterhub"]
