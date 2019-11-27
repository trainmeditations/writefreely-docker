#Download and extract official build
FROM alpine AS extractor
ARG version=0.11.1
ADD https://github.com/writeas/writefreely/releases/download/v${version}/writefreely_${version}_linux_amd64.tar.gz /
RUN /bin/tar -xzf /writefreely_${version}_linux_amd64.tar.gz

FROM debian:buster-slim
WORKDIR /opt/writefreely
#Adding WriteFreely
COPY --from=extractor /writefreely /opt/writefreely
EXPOSE 8080

WORKDIR /opt/writefreely/data
RUN chown daemon:daemon . ../keys
USER daemon
CMD [ "/opt/writefreely/writefreely" ]
