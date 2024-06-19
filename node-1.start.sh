besu \
  --data-path=node-1/data \
  --genesis-file=genesis.json \
  --network-id 10 \
  --rpc-http-enabled \
  --rpc-http-api=ETH,NET,CLIQUE,ADMIN \
  --host-allowlist="*" \
  --rpc-http-cors-origins="all" 