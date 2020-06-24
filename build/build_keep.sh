export PATH=$PATH:$PWD/tools

# change it to any folder you like
# export BUILD_FOLDER=keep

# go to https://github.com/keep-network/keep-core/releases
# and search for the release you want to build & ajust branch accordingly
# for example for release 'v.1.2.3-rc (Ropsten)' branch name will be 'v.1.2.3-rc'
export BRANCH=v1.2.0-rc.1
SCRIPTS_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 ; pwd -P )"
echo "SCRIPTS_DIR: $SCRIPTS_DIR"

# build random beacon node

# cd $BUILD_FOLDER

git clone https://github.com/keep-network/keep-core.git
cd keep-core
git checkout $BRANCH

cd solidity
npm update
cd ..
go generate ./.../

export KEEP_CLIENT_DIR=$PWD
$SCRIPTS_DIR/configure_keep.sh
unset KEEP_CLIENT_DIR

go run main.go
