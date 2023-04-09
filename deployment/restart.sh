#! /bin/bash
sudo docker stop site
sudo docker rm site
sudo docker ps -a
sudo docker pull nagyjames/project4:latest
sudo docker ps -a
sudo docker run -d -p 80:80 --name site nagyjames/project4:latest
sudo docker ps -a
