FROM mcr.microsoft.com/dotnet/runtime:8.0

RUN apt-get update && apt-get install -y --no-install-recommends bash && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /terraria /worlds /config

COPY ./server-files/ /terraria/srv
COPY run_server.sh /usr/local/bin/run_server.sh

RUN chmod +x /terraria/srv/TerrariaServer /usr/local/bin/run_server.sh

WORKDIR /terraria

ENTRYPOINT ["/usr/local/bin/run_server.sh"]