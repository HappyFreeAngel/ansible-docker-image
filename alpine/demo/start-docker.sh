#!/usr/bin/env bash

#docker load  --input ansible.image.tgz

firewall-cmd --add-port=2222/tcp --permanent 
firewall-cmd --reload

docker stop ansible
docker rm   ansible

docker run -d \
--name ansible \
-p 1880:80 \
-p 2222:22 \
-v `pwd`/app:/server/app \
 ascs/ansible:alpine3.10-support-ssh-login-1.0.0


docker container exec -ti ansible bash

