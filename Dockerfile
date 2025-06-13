FROM alpine:latest

ENV MC_VERSION="latest" \
    PAPER_BUILD="latest" \
    EULA="false" \
    MC_RAM="" \
    JAVA_OPTS=""

COPY mc.sh .
RUN apk update \
    && apk add libstdc++ \
    && apk add openjdk21-jre \
    && apk add bash \
    && apk add wget \
    && apk add jq \
    && mkdir /papermc

CMD ["bash", "./mc.sh"]

EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /papermc