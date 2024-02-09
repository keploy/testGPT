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

if [[ "$COMMAND" =~ .*"go".* ]]; then
  echo "go is present."
  go mod download
  go build -o application
  echo 'Test Mode Starting 🎉'
  echo sudo -E keploy test -c "./application" --delay ${DELAY} --path "${KEPLOY_PATH}"
  sudo -E keploy test -c "./application" --delay ${DELAY} --path "${KEPLOY_PATH}"

elif [[ "$COMMAND" =~ .*"node".* ]]; then
  echo "Node is present."
  npm install
  echo 'Test Mode Starting 🎉'
  echo sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"
  sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"

elif [[ "$COMMAND" =~ .*"java".* ]]  || [[ "$COMMAND" =~ .*"mvn".* ]]; then
  echo "Java is present."
  mvn clean install
  echo 'Test Mode Starting 🎉'
  echo sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"
  sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"

elif [[ "$COMMAND" =~ .*"python".* ]] || [[ "$COMMAND" =~ .*"python3".* ]]; then
  echo "Python is present."
  pip install -r requirements.txt
  echo 'Test Mode Starting 🎉'
  echo sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"
  sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"

elif [[ "$COMMAND" =~ .*"docker-compose".* ]] || [[ "$COMMAND" =~ .*"docker compose".* ]]; then
  echo "Docker compose is present."
  echo 'Test Mode Starting 🎉'
  echo sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}" --containerName "${CONTAINER_NAME}"
  sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}" --containerName "${CONTAINER_NAME}"

elif [[ "$COMMAND" =~ .*"docker".* ]]; then
  echo "Docker is present."
  echo 'Test Mode Starting 🎉'
  echo sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"
  sudo -E keploy test -c "${COMMAND}" --delay ${DELAY} --path "${KEPLOY_PATH}"


else
  echo "Language not found"
  echo 'Test Mode Shutting 🎉'
fi
