REGISTRY_ADDR = 
BASE_DIR = /opt/swarmsight

build-entrypoint-image:
	docker build -t generate-prom-config .

run-entrypoint:
	docker run -v $(BASE_DIR)/prometheus/prometheus.yaml:/app/prometheus.yaml generate-prom-config

run: 
	REGISTRY_ADDR=${REGISTRY_ADDR} docker stack deploy --with-registry-auth -c docker-compose.yaml swarmsight
