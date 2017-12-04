FROM alpine AS download
ADD https://caddyserver.com/download/linux/amd64?plugins=tls.dns.googlecloud&license=personal /opt/caddy.tar.gz
RUN tar -C /opt -xf /opt/caddy.tar.gz caddy

FROM abiosoft/caddy
COPY Caddyfile /etc/Caddyfile
COPY --from=download /opt/caddy /usr/bin/caddy
EXPOSE 80
EXPOSE 443
