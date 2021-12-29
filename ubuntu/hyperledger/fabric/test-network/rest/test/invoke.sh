SCRIPT="curl -v -s -k -X POST \
  http://127.0.0.1:7000/invoke \
  -H \"content-type: application/json\" \
  -d '{
    \"id\": \"sample_id\",
    \"hash\": \"c2FtcGxlX2lkCg==\"
  }' 2>/dev/null"

echo ${SCRIPT}
RESP=$(eval ${SCRIPT})
echo ${RESP}

