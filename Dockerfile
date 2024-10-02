# Use the official Prometheus base image
FROM prom/prometheus

# Crea el directorio para los logs y las consultas activas de Prometheus
RUN mkdir -p /var/data/prometheus

# Aplica el archivo prometheus.yml de este repositorio
ADD prometheus.yml /etc/prometheus/

# Configura el nombre del servicio Render en prometheus.yml
ARG RENDER_SERVICE_NAME
RUN sed -i "s/RENDER_SERVICE_NAME/${RENDER_SERVICE_NAME}/g" /etc/prometheus/prometheus.yml

# Establece la ruta de almacenamiento al disco persistente
CMD [ "--storage.tsdb.path=/var/data/prometheus", \
      "--config.file=/etc/prometheus/prometheus.yml", \
      "--web.console.libraries=/usr/share/prometheus/console_libraries", \
      "--web.console.templates=/usr/share/prometheus/consoles" ]
