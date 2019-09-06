#!/bin/bash
#USAGE
# ./generate_token USERNAME 
# creates an auth_token file for SPADE scripts

#The last line contains a string with the token
#In this version it's the third word of the line, so we cut the third word.
docker-compose run app manage drf_create_token $1 | tail -1 | cut -d " " -f 3 > auth_token
