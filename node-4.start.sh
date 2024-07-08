node_info=$(curl -s --location --globoff 'http://localhost:8545' \
    --data '{
        "jsonrpc": "2.0",
        "method": "admin_nodeInfo",
        "params": [],
        "id": 1
    }' | jq -r '.result.id')
    
export NODE_1_ENODE=enode://$node_info@127.0.0.1:30303


besu \
  --data-path=node-4/data \
  --genesis-file=genesis.json \
  --bootnodes=$NODE_1_ENODE \
  --network-id 10 \
  --p2p-port=60303 \
  --rpc-http-port=11545 \
  --rpc-http-enabled \
  --rpc-http-api=ETH,NET,CLIQUE \
  --rpc-http-host=0.0.0.0 \
  --host-allowlist="*" \
  --rpc-http-cors-origins="all" \
  --rpc-http-max-active-connections=3000