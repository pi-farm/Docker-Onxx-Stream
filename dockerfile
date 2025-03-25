FROM debian:12-slim
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-aarch64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-aarch64.tar.xz && tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
VOLUME /app/onxx-stream
COPY install.sh /app/build/
WORKDIR /app/build
RUN bash install.sh && cd .. && cp -r build/ onxx-stream/ 
WORKDIR /app/onxx-stream
RUN rm -rf /temp/* && rm -rf /var/lib/apt/lists/* && rm -rf build
ENTRYPOINT [ "/init" ]
