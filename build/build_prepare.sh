# install pre-requirements

# update all packages
sudo apt-get update && yes | sudo apt-get upgrade

# install abigen (required for building keep-core)
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get install ethereum -y

# install git & wget to clone repos and download dependencies
sudo apt-get install git wget -y

# install node & npm (required for building keep-core)
sudo apt-get install nodejs npm -y

# install packages required for building protobuf (required for building keep-core)
sudo apt-get install autoconf automake libtool curl make g++ unzip -y
git clone https://github.com/google/protobuf.git
cd protobuf
git submodule update --init --recursive
./autogen.sh
./configure
make
make check
sudo make install
sudo ldconfig
cd ..

go get -u github.com/gogo/protobuf/protoc-gen-gogoslick
# or 
sudo apt get install gogoprotobuf golang-github-gogo-protobuf-dev

# not sure whether this is really required
# go get -u golang.org/x/tools/cmd/stringer

mkdir tools
wget https://github.com/ethereum/solidity/releases/download/v0.5.17/solc-static-linux
mv solc-static-linux tools/solc
chmod +x tools/solc

export PATH=$PATH:$PWD/tools
