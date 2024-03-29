REGISTRY_ADDR = hub.docker.com

run: 
	docker build -t generate-prom-config .
	docker run -v $(pwd)/prometheus:/app generate-prom-config
	REGISTRY_ADDR=${REGISTRY_ADDR} docker stack deploy --with-registry-auth -c docker-compose.yaml swarmsight
