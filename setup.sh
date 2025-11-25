#!/bin/bash
echo "=== Configurando Prometheus ==="

# Cria a configuração do Prometheus
docker exec prometheus-monitoring sh -c "
cat > /etc/prometheus/prometheus.yml << 'EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node-exporter-local'
    static_configs:
      - targets: ['node-exporter-monitoring:9100']

  - job_name: 'servidor-windows-196'
    static_configs:
      - targets: ['10.1.1.196:9182']
    labels:
      instance: 'servidor-windows-196'

  - job_name: 'servidor-glpi'
    static_configs:
      - targets: ['172.17.17.30:9100']
    labels:
      instance: 'servidor-glpi'
EOF"

echo "✓ Configuração aplicada"

# Reinicia o Prometheus
docker restart prometheus-monitoring

echo "✓ Prometheus reiniciado"
echo "=== Configuração concluída ==="
echo ""
echo "URLs:"
echo "Prometheus: http://localhost:19090"
echo "Grafana: http://localhost:13000 (admin/admin123)"
echo "Node Exporter: http://localhost:19100"
