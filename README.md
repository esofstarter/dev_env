##  Run Development Environment

1. In the dev_env_nuxt directory copy .env.sample to .env
```shell
cp .env.sample .env
```

2. Make sure to configure the ports in the .env file if the local system uses the defaults
```shell
vim .env
```

3. From dev_env_nuxt run:
```shell
docker-compose build
docker-compose up
```

4. Test if the container volumes mounted succesfully
```shell
sudo docker exec -it app /bin/bash
```
- look for the project inside the eventlokale directory
```shell
sudo docker exec -it node /bin/bash
```
-  look for the project inside the usr/app directory

### Tips

If there is some issue with the docker configuration at this point and you have previosely run an older configuration please try clearing the cache from the broken docker-compose version
```shell
docker stop $(docker ps -a -q)
docker system prune -a
```
- and re do step 3

## Useful commands:

Get a list of all running or failed containers
```shell
docker ps -a
```
To execute commands inside a container
```shell
docker exec -it app /bin/bash
```
Run a container for a service defined in the docker-compose.yaml file. You will have to execute this command from the dev_env folder
```shell
docker-compose run node /bin/bash
```
Clear all docker cache containers networks etc ... This will remove docker containers for other projects too not just starter
```shell
docker system prune -a
```