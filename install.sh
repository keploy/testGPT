#!/bin/bash

# Install Keploy binary using curl command
curl --silent --location "https://github.com/keploy/keploy/releases/latest/download/keploy_linux_amd64.tar.gz" | tar xz -C /tmp
echo curl --silent --location "https://github.com/keploy/keploy/releases/latest/download/keploy_linux_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/keploy /usr/local/bin/keploy
chmod +x /usr/local/bin/keploy
echo "Keploy installed successfully 🎉"

cd ${GITHUB_WORKSPACE}/${WORKDIR}
echo "${GITHUB_WORKSPACE}/${WORKDIR}"
# Generate app binary
echo "ls"
ls

# Check for supported languages
if [[ "$COMMAND" =~ .*"go".* ]]; then
  echo "go is present."
  go mod download
  go build -o application
  echo 'Test Mode Starting 🎉'
  sudo -E keploy test -c "./application" --delay ${DELAY} --path "${KEPLOY_PATH}"

elif [[ "$COMMAND" =~ .*"node".* ]]; then
  echo "Node is present."
  npm install
  echo 'Test Mode Starting 🎉'
  sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"

elif [[ "$COMMAND" =~ .*"java".* ]]  || [[ "$COMMAND" =~ .*"mvn".* ]]; then
  echo "Java is present."
  mvn clean install
  echo 'Test Mode Starting 🎉'
  sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"

elif [[ "$COMMAND" =~ .*"python".* ]] || [[ "$COMMAND" =~ .*"python3".* ]]; then
  echo "Python is present."
  pip install -r requirements.txt
  echo 'Test Mode Starting 🎉'
  sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"

elif [[ "$COMMAND" =~ .*"docker".* ]]; then
  echo "Docker command is present."
  # Run Docker command
  echo 'Test Mode Starting 🎉'
  if [[ "$COMMAND" =~ .*"docker".* ]]; then
    echo "Docker command is present."
    # Run Docker command
    echo 'Test Mode Starting 🎉'
    if [[ "$COMMAND" =~ .*"docker-compose".* ]]; then
      sudo -E keploy test -c "${COMMAND}" --buildDelay ${DELAY} --containerName "${CONTAINER_NAME}" --path "${KEPLOY_PATH}"
    else
      sudo -E keploy test -c "${COMMAND}" --buildDelay ${DELAY} --path "${KEPLOY_PATH}"
    fi

else
  echo "Language or command not found"
  echo 'Test Mode Shutting 🎉'
fi
