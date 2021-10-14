. .env

if [ -d ${DATADIR} ]; then
  rm -rf ${DATADIR}
fi
geth account new --datadir ${DATADIR}

