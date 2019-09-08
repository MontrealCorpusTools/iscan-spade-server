#!/bin/bash
docker-compose build --build-arg UPGRADE=y
docker-compose run app init 
