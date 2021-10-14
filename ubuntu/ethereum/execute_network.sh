. .env

if [ ! -d ${HISTORYDIR} ]; then
  mkdir ${HISTORYDIR}
fi

geth --datadir ${DATADIR} --networkid ${NETWORKID} console 2>> ${HISTORYDIR}/network.log
