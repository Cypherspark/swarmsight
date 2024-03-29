# SwarmSight

This repository provides a dynamic solution for generating Prometheus configurations, aimed specifically at monitoring services within a Docker Swarm cluster. Leveraging a Go application and Docker, it automates the creation of a `prometheus.yml` configuration file based on service details specified in `services.yaml`. This tool simplifies the process of setting up Prometheus for comprehensive monitoring of your Swarm cluster.

## Overview

The project facilitates the monitoring of Docker Swarm clusters by:

1. **Defining Services:** Allowing detailed specification of services to be monitored within the `services.yaml` file.
2. **Automating Config Generation:** Utilizing a Go application to process these details and generate a `prometheus.yml` file tailored for your Swarm services.
3. **Simplifying Deployment:** Providing an automated deployment process into a Docker Swarm stack, employing the generated configuration.

## Prerequisites

* Docker and Docker Swarm initialized
* docker-compose
* Make
* Git (for cloning the repository)

## Quickstart

1. **Clone the Repository:**
   Begin by cloning this repository to set up Prometheus for monitoring your Docker Swarm cluster.

   ```bash
   git clone https://github.com/Cypherspark/swarmsight.git
   cd swarmsight
   ```
2. **Define Your Swarm Services:**
   Modify `services.yaml` to include the services within your Docker Swarm cluster that you wish to monitor with Prometheus.
3. **Deploy Using Make:**
   Execute the following command to build the Docker image, generate the `prometheus.yml`, and deploy Prometheus to your Docker Swarm stack:

   ```bash
   make build-entrypoint-image
   make run-entrypoint
   make run REGISTRY_ADDR=<your-registry-address>
   ```

   Replace `<your-registry-address>` with your actual Docker registry address if necessary.

## Goal

The primary goal of this project is to enable efficient and scalable monitoring of Docker Swarm clusters. By automating Prometheus configuration generation and deployment, it aims to streamline the operational overhead associated with monitoring large-scale Swarm environments.

## Contributing

Contributions to enhance this tool are welcome. If you've identified improvements or found bugs, feel free to open an issue or submit a pull request.
