global:
  scrape_interval:     15s
  evaluation_interval: 15s

  external_labels:
    monitor: 'swarmsight'

rule_files:
  - "swarm_node.rules.yml"
  - "swarm_task.rules.yml"

scrape_configs:
  - job_name: 'statsd-exporter'
    dns_sd_configs:
    - names:
      - 'tasks.statsd-exporter'
      type: 'A'
      port: 9102
	
  - job_name: 'dockerd-exporter'
    dns_sd_configs:
    - names:
      - 'tasks.dockerd-exporter'
      type: 'A'
      port: 9323

  - job_name: 'cadvisor'
    dns_sd_configs:
    - names:
      - 'tasks.cadvisor'
      type: 'A'
      port: 8080

  - job_name: 'node-exporter'
    dns_sd_configs:
    - names:
      - 'tasks.node-exporter'
      type: 'A'
      port: 9100
    
{{- range .Services }}
  - job_name: '{{ .Name }}'
    metrics_path: '{{ .MetricsPath }}'
    dockerswarm_sd_config:
      - host: unix:///var/run/docker.sock
        role: tasks
        filters:
          - name: label
            values: ['com.docker.swarm.service.name={{ .Name }}']
    relabel_configs:
      - source_labels: [__meta_docker_task_container_label_com_docker_swarm_service_name]
        action: keep
        regex: {{ .Name }}
      - source_labels: [__address__]
        target_label: __address__
        regex: (.*):.*
        replacement: $1:{{ .Port }}
      - source_labels: [__meta_docker_task_container_label_com_docker_swarm_service_name]
        target_label: instance
{{- end }}
