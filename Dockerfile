FROM alpine:latest

COPY mc.sh .
RUN apk update \
    && apk add libstdc++ \
    && apk add openjdk21-jre \
    && apk add bash \
    && apk add wget \
    && apk add jq \
    && mkdir /papermc


EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /papermc