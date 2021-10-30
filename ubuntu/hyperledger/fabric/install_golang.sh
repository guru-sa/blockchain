#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`
cd ${SCRIPTPATH}

set -x
. ~/.bashrc
which go
if [ "$?" -eq "0" ]; then
  exit 0
fi

GO_VER=1.16.7
GO_URL=https://storage.googleapis.com/golang/go${GO_VER}.linux-amd64.tar.gz

export GOROOT="/opt/go"
export GOPATH="/opt/gopath"
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH

echo "export GOROOT=$GOROOT" >> ~/.bashrc
echo "export GOPATH=$GOPATH" >> ~/.bashrc
echo "export PATH=$GOROOT/bin:$GOPATH/bin:$PATH" >> ~/.bashrc

cat <<EOF >/etc/profile.d/goroot.sh
export GOROOT=$GOROOT
export GOPATH=$GOPATH
export PATH=\$PATH:$GOROOT/bin:$GOPATH/bin
EOF

mkdir -p $GOROOT
curl -sL $GO_URL | (cd $GOROOT && tar --strip-components 1 -xz)
if [ "$?" -ne "0" ]; then
  echo "========= ERROR!!! FAILED to execute script ==========="
  exit 1
fi

set +x
exit 0
