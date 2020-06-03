# change it to any path you like
export GOPATH=/mnt/e/GOPATH
export PATH=/usr/local/go/bin:$PATH
echo "PATH: $PATH"

wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz
sudo tar -xvf go1.13.3.linux-amd64.tar.gz
sudo mv go /usr/local
