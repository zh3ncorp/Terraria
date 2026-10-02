FROM debian:bookworm-slim

RUN mkdir -p /terraria /worlds /config

COPY ./server-files/ /terraria/srv
COPY run_server.sh /usr/local/bin/run_server.sh

RUN chmod +x /terraria/srv/TerrariaServer* /usr/local/bin/run_server.sh

WORKDIR /terraria

# Проверяем только, что порт 7777 слушается (0x1E61, состояние 0A = LISTEN).
# Не открываем TCP-соединение к серверу: начиная с 1.4.5.7 сервер может падать
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=5 \
  CMD grep -sqiE ':1E61 [0-9A-F]+:0000 0A' /proc/net/tcp /proc/net/tcp6 || exit 1

ENTRYPOINT ["/usr/local/bin/run_server.sh"]