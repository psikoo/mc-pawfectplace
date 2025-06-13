FROM alpine:latest

COPY mc.sh .
RUN apk update \
    && apk add libstdc++ \
    && apk add openjdk21-jre \
    && apk add bash \
    && apk add curl \
    && apk add jq \
    && mkdir /papermc

CMD ["bash", "./mc.sh"]

EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /papermc