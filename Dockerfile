FROM fedora:25
COPY root /opt/docker/
RUN ["/usr/bin/sh", "/opt/docker/run.sh"]
ENTRYPOINT ["/usr/bin/sh", "/opt/docker/entrypoint.sh"]