mvn clean install
docker build -t matsishin/kuber-backend:0.1 .
docker image push matsishin/kuber-backend:0.1