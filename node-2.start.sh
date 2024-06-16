export NODE_1_ENODE=<node1 enode>

besu \
  --data-path=node-2/data \
  --genesis-file=genesis.json \
  --bootnodes=$NODE_1_ENODE \
  --network-id 10 \
  --p2p-port=40303 \
  --rpc-http-port=9545 \
  --rpc-http-enabled \
  --rpc-http-api=ETH,NET,CLIQUE \
  --host-allowlist="*" \
  --rpc-http-cors-origins="all"