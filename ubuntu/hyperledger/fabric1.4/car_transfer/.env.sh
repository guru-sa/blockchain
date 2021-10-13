set -x
export GOPATH=`pwd`/chaincode:`pwd`/fabric
mkdir -p fabric/src/github.com/hyperledger/
pushd fabric/src/github.com/hyperledger/
git clone -b v1.4.9 --depth=1 -c advice.detachedHead=false https://github.com/hyperledger/fabric.git
popd
go get -u github.com/jinzhu/inflection
go get -u github.com/stretchr/testify/assert

# install go vendor
go get -u github.com/kardianos/govendor

# make directory to build
mkdir .build
cp -r ./chaincode/* ./.build
export GOPATH=`pwd`/.build:`pwd`/fabric
export PATH=`pwd`/.build/bin:$PATH

# vendoring
pushd .build/src/cartransfer/main
govendor init
govendor add cartransfer
govendor add cartransfer/chaincode
govendor add github.com/jinzhu/inflection
popd

# dist
mkdir -p dist && cd ./build && cp -r --parents src/cartransfer/main ../dist && cd ..
