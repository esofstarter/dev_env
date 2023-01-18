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

## Configuration of the Application

1. Copy website/sample-dev-env.env to website/.env
2. Go to workbench or phpmyadmin and create database schema starter
- import database dump from dev server [OPTIONAL for ongoing projects]

## Build Application

### Install PHP Dependencies
```shell
sudo docker exec -it app /bin/bash
```
inside of the website folder run
```shell
composer install && php artisan config:cache && php artisan view:clear && php artisan route:clear && composer dump-autoload && php artisan vue-i18n-custom:generate && php artisan migrate
```

### Tips

(OPTIONAL only first time) Go to website/ outside of docker and run:
```shell
sudo chown -R www-data. . && sudo setfacl -R -m u:$USER:rwx .
```

Make sure to disable the firewall to use Xdebug:
```shell
ufw disable
```

#### Possible errors
- node | error Couldn't find a package.json file in "/usr/app" (NODE_ROOT=~/development/repositories/starter/website is missing from the env file. The path is just an example)
- Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get ..... (Run the command with elevated permissions on ubuntu sudo.)
- Command 'composer' not found, but can be installed with (did you run the command inside the container after executing the previous line?)
- inside node yarn nuxt:dev fails with Unexpected token u in JSON at position ... in nuxt-config.ts (the issue here is that the .env file is missing or the variable is not defined)

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