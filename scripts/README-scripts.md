# Scripts with skymotic/JupyterHub

These scripts will be copied over to the Docker Image in the location:  
`/scripts/`  

> Currently none of the scripts run by default

## `userCreate.sh` Script

In the case your docker container got destoryed or corrupted this script is designed to search a persistant `/home/` volume for users. It will then Re-Create the users, set home directory ownership, and reset their passwords to `Colorado2022`

> For Security Reasons I could not keep the previous password

### Running Script

By default your working directory should be set to the script folder so you don't need to get all the way into the dockers bash shell.

Instead run the following command:

```bash
docker exec -it <ContainerID> /bin/bash bash userCreate.sh
```

> Notice the `exec` option; tells docker to execute a command

> Notice the `-it` option; this runs the command in interactive mode

> Notice the `<ContainerID>`; This should be the name or ID number of your running container

> Notice the `/bin/bash`; This tells the docker container to run the following commands in the bash shell

> Notice the `bash userCreate.sh`; This is the part that actually runs the script on your docker container

Done!!!

---
