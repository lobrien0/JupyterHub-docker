# JupyterHub-docker

This Docker Image contains an easy setup and deployment of JupyterHub ( A JupyterLab Web Server )  
Before you move any further, make sure docker is on your system. If not you can download it here:
[Get Docker](https://docs.docker.com/get-docker/)

### Method #1
*Docker Compose* (Easy Difficulty)

### Method #2
*Pull Docker Image from a Docker Repository* (Medium-Easy Difficulty)

### Method #3
*Build the Docker Image from the* `Dockerfile` *in this GitHub* (Medium-Hard Difficulty)

[Creating Login](https://github.com/skymotic/JupyterHub-docker#creating-login)
*Instructions to create your login once the Docker Container is running*

# Method #1: Docker Compose

I have written a compose file that does all the work for you.

The advantages of running it this way; the `.yaml` will create persistance storage through the use of docker volumes.  
This means if you delete the container or it gets corrupted, you can just delete the old conatiner and re-run the compose file and all user logins and files should be restored.

1. Download `docker-compose.yaml` from this GitHub Repo and put it on your linux enviorment

2. Run the following command:

   ```bash
   docker compose up -d
   ```
   
   > `up` tell the command to read a compose file  

   > `-d` tells the command to run the compose file detached from the new terminal   

### Short Descption of what the compose file does:

This compose file will first create the volumes specified and attach them to the container as it spins up.
It will also open port `8088`

# Method #2: From Docker Repository

> **Quick note:** This options is great for container customization, but reqires some Docker know-how if you want to do more than the default.

You can *pull* and *run* the image all with one command

```bash
docker run -d -p 8088:8000 lobr266238/jupyterhub-basic:alpine		# Will pull the alpine image
```
> Notice the `-d` option; This allows us to start the container in *Headless Mode* or detached from the current shell

> Notice the `-p 8088:8000` option; This opens the port 8088 on the host machine so we can connect the web server  
> `8088:8000` specifies both the Host machines port and the containers port in order: `<HostPort>:<DockerPort>`  
> If you would like to open this container on a differnt port subsitute this: `-p <NewPort>:8000`

> `lobr266238/jupyterhub-basic:alpine` calls Docker to look at Account: `lobr266238`, Repository: `jupyterhub-basic`, Tag: `alpine`

---

# Method #3: Build From Files
In order to do this method, you will need to download the `Dockerfile` from this repository and put it in its own folder before continuing
## Step 1: Docker Build Process

1. Make sure [docker](https://docs.docker.com/get-docker/) is installed on you system

2. In the command line, navigate to the Directory your `Dockerfile` is in (for example `/apps/jupyter`)

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


## Step 2: Start Docker Container

By default, the image is configured be started and immediately ready to use.

1. To start a container from the image we just built, do the following:

   ```bash  
   docker run -d -p 8088:8000 <ImageName>
   ```  
   > Notice the `-d` option: This allows us to start the container detached from your current shell session

   > Notice the `-p 8088:8000` option: This exposes port 8088 to your host system.  
   > 8000 is the default JupyterHub port.  
   > `-p <HostPort>:<ContainerPort>`
   
   >`<ImageName>` is the name you had set earlier in the *Docker Build Process*
---  
# Creating Login

By defualt, the docker's container uses PAM for authentication (which is intigreated for the containers OS users)  
In order to create a login for yourself or others to use for jupyterhub server, you will need to enter the container shell and add the users:

1. Getting the container ID

   ```bash
   docker ps
   ```  
   > Notice the `ps` command shows all running docker containers
   
   Find the running container and copy the ID shown
   
2. Entering the Container's shell where `<ContainerID>` is the ID from the last step

   ```bash
   docker exec -it <ContainerID> /bin/bash
   ```  
   > Notice the `exec` command allows you to execute a command on the docker container
   
   > Notice the `-it` option allows us to enter commands in *Interactive Mode*
   
   > Notice the `/bin/bash` allows us to enter into a full interactive shell
   
3. Once in the Container's shell we will need to add each user

   ```bash
   adduser <USERNAME>
   ```  
   You can repeat this command for as many users as you need. (I will be working on a way to add users by script)
   
4. This should allow you to sign into the jupyter server with the user you have created
---
## END
Using one of the 3 methods above you should now have a running Docker Container with a working JupyterHub Server  
To get to the webpage go to <http://localhost:8000/>

### External Website
If you want to connect this to a domain and/or any external website, I'd strongly recommend that you set up an Nginx or Apache reverse proxy using SSL and a firewall  

An example of an `nginx Reverse Proxy` is in the Repo  
It would go under `/etc/nginx/conf.d/`
