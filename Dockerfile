FROM alpine:3

WORKDIR /tmp
ARG VERSION=2.27.1
RUN apk add --no-cache rsync jq nano curl
ADD install.sh .
RUN ./install.sh

ADD run.sh /bin/run.sh

ENTRYPOINT [ "/bin/run.sh" ]
