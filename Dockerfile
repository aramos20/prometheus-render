FROM prom/prometheus:latest

USER root

# Create the directory for Prometheus logs and active queries
RUN mkdir -p /var/data/prometheus

# Copy your prometheus.yml configuration file to the container
COPY prometheus.yml /etc/prometheus/prometheus.yml

# Expose the necessary port for Prometheus
EXPOSE 9090

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
