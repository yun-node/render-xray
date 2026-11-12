# Render xray node — privacy-safe build
# - No secret in the repo/image: UUID and PORT come from Render environment variables.
# - UUID is a fresh one for Render only (never the Cloady UUID).
# - Same protocol as the other nodes: VLESS + WebSocket + TLS, path /tk-rail.
FROM ghcr.io/xtls/xray-core:latest AS xray
FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY config.template.json /etc/xray/config.template.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 10000
ENTRYPOINT ["/entrypoint.sh"]
