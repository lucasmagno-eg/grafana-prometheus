#!/bin/bash
# Corrige automaticamente a configuração do Prometheus

cat > /tmp/prometheus-corrected.yml << 'EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter-monitoring:9100']
        labels:
          instance: 'node-exporter-local'

  - job_name: 'windows-exporter'
    static_configs:
      - targets: ['10.1.1.196:9182']
        labels:
          instance: 'windows-server-196'

  - job_name: 'servidor-glpi'
    static_configs:
      - targets: ['172.17.17.30:9100']
        labels:
          instance: 'glpi-server'
EOF

# Copia para o container quando ele subir
docker cp /tmp/prometheus-corrected.yml prometheus-monitoring:/etc/prometheus/prometheus.yml