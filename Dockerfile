#Download and extract official build
FROM alpine AS extractor
ARG version=0.13.2
ADD https://github.com/writeas/writefreely/releases/download/v${version}/writefreely_${version}_linux_amd64.tar.gz /
RUN /bin/tar -xzf /writefreely_${version}_linux_amd64.tar.gz

FROM debian:bullseye-slim
WORKDIR /opt/writefreely
#Adding WriteFreely
COPY --from=extractor /writefreely /opt/writefreely
EXPOSE 8080

RUN mkdir data && chown daemon:daemon data keys
USER daemon
CMD [ "/opt/writefreely/writefreely", "-c", "/opt/writefreely/data/config.ini" ]
