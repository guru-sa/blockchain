SCRIPT="curl -v -s -k -X POST \
  http://127.0.0.1:7000/query \
  -H \"content-type: application/json\" \
  -d '{
    \"id\": \"sample_id\"
  }' 2>/dev/null"

echo ${SCRIPT}
RESP=$(eval ${SCRIPT})
echo ${RESP}

