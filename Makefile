REGISTRY_ADDR = hub.docker.com
BASE_DIR = /opt/swarmsight

run: 
	docker build -t generate-prom-config .
	docker run -v $(BASE_DIR)/prometheus/prometheus.yaml:/app/prometheus.yaml generate-prom-config
	REGISTRY_ADDR=${REGISTRY_ADDR} docker stack deploy --with-registry-auth -c docker-compose.yaml swarmsight
