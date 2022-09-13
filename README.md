# JupyterHub-docker

This repository containes the file/s to build a docker image designed to run JupyterHub (a JupyterLabs Web Server)

The Overall point of this Docker Image is to allow an easy setup and deployment of a JupyterHub server while having to do almost no configuration.


## Build Docker Image

1. Make sure [docker](https://docs.docker.com/get-docker/) is installed on you system

2. In the command line, navigate to the project's root directory (for example I'll be using `/apps/jupyter`)

3. Run the Docker Build command where `<NAME>` is whatever you choose:

   ```bash
   docker build -t <NAME> .
   ```
   > Notice the `-t` option; This is to *tag* the image with a name. The name has to be all lowercase
   
   > Notice the `.` at the end of the command; This is very intentional.  
   > This singnals the Docker command to look for the Dockerfile in the `pwd` or *Present Working Directory*

   The build process should start; Depending on the machine it can take a little while

4. Once the build had finished, enter the following to ensure your image was created

   ```bash  
   docker images
   ```
   >You should see an image with the *tag* you set earlier in step 3


## Start Docker Container

By default, the image is configured be started and immediately ready to use.

1. To start a container from the image we just built, enter:

   ```bash  
   docker run -d -p 8000:8000
   ```  
   > Notice the `-d` option: This allows us to start the container detached from your current shell session

   > Notice the `-p 8000:8000` option: This exposes port 8000 to your host system.  
   > 8000 is the default JupyterHub port.  
   > `-p <HostPort>:<ContainerPort>`
---
### DONE
The Docker Image should be built, and you should now have a running docker container with a working JupyterHub Server  
To get to the webpage go to <http://localhost:8000/>

### External Website
If you want to connect this to a domain and external website, I'd strongly recommend that you set up an Nginx or Apache reverse proxy using SSL and a firewall
