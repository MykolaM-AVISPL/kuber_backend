#!/bin/sh
version="0.2.2"
mvn clean install
docker build -t "matsishin/kuber-backend:$version" .
docker login
docker image push "matsishin/kuber-backend:$version"