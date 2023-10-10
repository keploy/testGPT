#!/usr/bin/env bash

# Install Keploy binary using curl command
curl --silent --location "https://github.com/keploy/keploy/releases/latest/download/keploy_linux_amd64.tar.gz" | tar xz -C /tmp
echo curl --silent --location "https://github.com/keploy/keploy/releases/latest/download/keploy_linux_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/keploy /usr/local/bin/keploy
chmod +x /usr/local/bin/keploy

echo "Keploy installed successfully 🎉"

cd ${WORKDIR}
echo "${WORKDIR}"
# Generate app binary
go mod download
go build -o application

echo 'Test Mode Starting 🎉'

pwd && sudo -E keploy test -c "./application" --delay ${DELAY} --debug
echo sudo -E keploy test -c "./application" --delay ${DELAY}
