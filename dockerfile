FROM debian:12-slim
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-aarch64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-aarch64.tar.xz && tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
COPY install.sh /app/
VOLUME /app/RPi-PXE-Server
RUN rm -rf /temp/* && rm -rf /var/lib/apt/lists/*
WORKDIR /app/onxx-stream
ENTRYPOINT [ "/init" ]
