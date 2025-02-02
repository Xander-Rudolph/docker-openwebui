FROM searxng/searxng:latest

LABEL org.opencontainers.image.authors="Xander-Rudolph"
LABEL org.opencontainers.image.contact="https://github.com/Xander-Rudolph"
LABEL org.opencontainers.image.source="https://github.com/xander-rudolph/docker-openwebui"
LABEL org.opencontainers.image.vendor="searxng"
LABEL org.opencontainers.image.title="searxng with modified xml"
LABEL org.opencontainers.image.description="Image for running searxng with json supported by default"
LABEL org.opencontainers.image.usage="This image is intended for using and enabling web search in open-webui since it uses json responses."
LABEL org.opencontainers.image.created="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
LABEL org.opencontainers.image.base="searxng/searxng:latest"

# Append - json after - html in the formats block safely
RUN grep -q 'formats:' /etc/searxng/settings.yml && \
    sed -i '/^[[:space:]]*- html/a\  - json' /etc/searxng/settings.yml || \
    echo "formats block not found or already updated."

EXPOSE 8080

CMD ["python3", "-m", "searxng"]
