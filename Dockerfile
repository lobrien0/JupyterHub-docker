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
RUN mkdir -p /app/
WORKDIR /app/
RUN python3 -m pip install jupyterlab
RUN python3 -m pip install jupyterhub
RUN python3 -m pip install jupyterhub-nativeauthenticator

# NPM install, Mangages all the Web handlers to provide a webpage over select ports
RUN npm install -g configurable-http-proxy

# Create Default User & change the password to 'DeltaAlpha21'
RUN useradd -m jupyteradmin
RUN echo "jupyteradmin:DeltaAlpha21" | chpasswd -c SHA512

# Moves the config file to the JupyterHub Container
# The config changed the authentication to native-Authenticator
COPY ./jupyterhub_config.py /app/

# Copys over a UNIX user creation script and adds a call to the Native Authenticator-
# Python Library for proper user creation
COPY ./newUser.sh /app/
RUN sed -i "335i \ \ \ \ \ \ \ \ os.system(f'bash /app/newUser.sh {username}')" /usr/local/lib/python3.10/dist-packages/nativeauthenticator/nativeauthenticator.py

# The port that needs to be exposed to the host system 
# Port 8000 is what the server listens on
EXPOSE 8000

# Runs the container with this command as primary process
CMD ["jupyterhub","-f","/app/jupyterhub_config.py"]