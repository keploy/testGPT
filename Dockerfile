FROM golang:1.20 AS bookworm

WORKDIR /app

COPY . /app

# === Runtime Stage ===
FROM ubuntu:latest

# Install curl and sudo
RUN apt-get update && \
    apt-get install -y curl sudo && \
    rm -rf /var/lib/apt/lists/*

RUN chmod +x install.sh

ENTRYPOINT [ "install.sh" ]