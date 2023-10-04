FROM golang:1.20 AS bookworm

WORKDIR /app

# === Runtime Stage ===
FROM ubuntu:latest

# Install curl and sudo
RUN apt-get update && \
    apt-get install -y curl sudo && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh


ENTRYPOINT [ "/app/install.sh" ]