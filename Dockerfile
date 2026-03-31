FROM twinproduction/gatus:latest

COPY gatus/config/config.yaml /config/config.yaml

ENV GATUS_CONFIG_PATH=/config/config.yaml

EXPOSE 8080