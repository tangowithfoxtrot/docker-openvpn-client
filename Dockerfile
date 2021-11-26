FROM alpine:3.14

ARG IMAGE_VERSION
ARG BUILD_DATE

LABEL source="github.com/tangowithfoxtrot/docker-openvpn-client"
LABEL version="$IMAGE_VERSION"
LABEL created="$BUILD_DATE"

ENV KILL_SWITCH=on \
    VPN_LOG_LEVEL=3 \
    HTTP_PROXY=off \
    SOCKS_PROXY=off

RUN apk add --no-cache \
        bind-tools \
        dante-server \
        openvpn \
        curl \
        fish \
        tinyproxy

RUN mkdir -p /data/vpn

COPY data/ /data

HEALTHCHECK CMD ping -c 3 9.9.9.9 || exit 1

ENTRYPOINT ["/data/scripts/entry.sh"]
