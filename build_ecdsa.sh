export PATH=$PATH:$PWD/tools

# change it to any folder you like
# export BUILD_FOLDER=keep

# go to https://github.com/keep-network/keep-core/releases
# and search for the release you want to build & ajust branch accordingly
# for example for release 'v1.0.0' branch name will be 'v1.0.0'
export BRANCH=v1.0.0
SCRIPTS_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 ; pwd -P )"
echo "SCRIPTS_DIR: $SCRIPTS_DIR"

# build ecdsa node

# cd $BUILD_FOLDER

git clone https://github.com/keep-network/keep-ecdsa.git
cd keep-ecdsa
git checkout $BRANCH

cd solidity
npm update
cd ..
go generate ./.../

#export KEEP_CLIENT_DIR=$PWD
#$SCRIPTS_DIR/configure_keep.sh
#unset KEEP_CLIENT_DIR

go run main.go
