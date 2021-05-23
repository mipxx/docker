FROM alpine:3.13

# install setup-scripts & configure system
RUN apk add --no-cache alpine-conf
RUN setup-timezone -z Europe/Berlin
RUN setup-hostname -n unbound

# unbound
RUN apk add --no-cache unbound drill
RUN wget https://www.internic.net/domain/named.root -O /usr/share/dns-root-hints/named.root
RUN wget https://www.internic.net/domain/named.root.sig -O /usr/share/dns-root-hints/named.root.sig
RUN echo ". IN DS 20326 8 2 E06D44B80B8F1D39A95C0B0D7C65D08458E880409BBC683457104237C7F8EC8D" >> /etc/unbound/root.key
RUN chown unbound:unbound /etc/unbound /etc/unbound/root.key
# https://calomel.org/unbound_dns.html
COPY unbound.conf /etc/unbound/unbound.conf

EXPOSE 53/tcp
EXPOSE 53/udp

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s CMD drill @127.0.0.1 cloudflare.com || exit 1

ENTRYPOINT [ "unbound", "-d" ]