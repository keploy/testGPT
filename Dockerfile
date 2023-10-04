FROM golang:1.20 AS bookworm

WORKDIR /app

COPY . /app

# === Runtime Stage ===
FROM ubuntu:latest

# Install curl and sudo
RUN apt-get update && \
    apt-get install -y curl sudo && \
    rm -rf /var/lib/apt/lists/*

COPY install.sh /app/install.sh

RUN chmod +x /app/install.sh

ENTRYPOINT [ "/app/install.sh" ]