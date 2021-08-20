FROM alpine:3

WORKDIR /tmp
ARG VERSION=2.29.1
RUN apk add --no-cache rsync jq nano curl
ADD install.sh .
RUN ./install.sh

ADD run.sh /bin/run.sh

ENTRYPOINT [ "/bin/run.sh" ]
LABEL "org.opencontainers.image.version"="2.29.1"
