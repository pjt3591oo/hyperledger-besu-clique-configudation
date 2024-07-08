besu \
  --data-path=node-1/data \
  --genesis-file=genesis.json \
  --network-id 10 \
  --rpc-http-enabled \
  --rpc-http-api=ETH,NET,CLIQUE,ADMIN,TRACE,DEBUG \
  --host-allowlist="*" \
  --rpc-http-cors-origins="all" \
  --rpc-http-max-active-connections=3000
