FROM alpine:3.13

# install setup-scripts & configure system
RUN apk add --no-cache alpine-conf
RUN setup-timezone -z Europe/Berlin
RUN setup-hostname -n knot-resolver

# unbound
RUN apk add --no-cache knot-resolver drill
RUN mkdir /var/lib/knot-resolver
RUN chown kresd:kresd /var/lib/knot-resolver
COPY kresd.conf /etc/knot-resolver/kresd.conf

EXPOSE 53/tcp
EXPOSE 53/udp

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s CMD drill @127.0.0.1 cloudflare.com || exit 1

ENTRYPOINT [ "kresd", "-n", "-c", "/etc/knot-resolver/kresd.conf",  "/var/lib/knot-resolver" ] 