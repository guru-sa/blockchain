set -x
export GOPATH=`pwd`/chaincode:`pwd`/fabric
mkdir -p fabric/src/github.com/hyperledger/
pushd fabric/src/github.com/hyperledger/
git clone -b v1.4.9 --depth=1 -c advice.detachedHead=false https://github.com/hyperledger/fabric.git
popd
go get -u github.com/jinzhu/inflection
go get -u github.com/stretchr/testify/assert