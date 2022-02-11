#!/bin/bash
docker run \
	--name auth \
	-v /etc/auth_microservice:/etc/auth_microservice \
	-p 8080:8080 \
	auth_microservice
