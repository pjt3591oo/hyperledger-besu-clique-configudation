export NODE_1_ENODE=<node1 enode>

besu \
  --data-path=node-4/data \
  --genesis-file=genesis.json \
  --bootnodes=$$NODE_1_ENODE \
  --network-id 10 \
  --p2p-port=60303 \
  --rpc-http-port=11545 \
  --rpc-http-enabled \
  --rpc-http-api=ETH,NET,CLIQUE \
  --host-allowlist="*" \
  --rpc-http-cors-origins="all"