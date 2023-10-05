# Path: install.sh
#if ! [ -z ${GITHUB_WORKSPACE} ]; then
#    echo "Please run this from where main.go file is present"
#    exit 1
#fi

# Install Keploy binary using curl command
curl --silent --location "https://github.com/keploy/keploy/releases/latest/download/keploy_linux_amd64.tar.gz" | tar xz -C /tmp
echo curl --silent --location "https://github.com/keploy/keploy/releases/latest/download/keploy_linux_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/keploy /usr/local/bin/keploy
echo sudo mv /tmp/keploy /usr/local/bin/keploy

chmod +x /usr/local/bin/keploy

echo "Keploy installed successfully 🎉"

# Generate app binary
go mod download
echo 'mod download'
go build -o application
echo 'go build -o application .'

sudo -E keploy test -c "${GITHUB_WORKSPACE}/application" --delay ${DELAY} --debug
echo sudo -E keploy test -c "${GITHUB_WORKSPACE}/application" --delay ${DELAY}