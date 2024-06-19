node_info=$(curl -s --location --globoff 'http://localhost:8545' \
    --data '{
        "jsonrpc": "2.0",
        "method": "admin_nodeInfo",
        "params": [],
        "id": 1
    }' | jq -r '.result.id')
    
export NODE_1_ENODE=enode://$node_info@127.0.0.1:30303

besu \
  --data-path=node-5/data \
  --genesis-file=genesis.json \
  --bootnodes=$NODE_1_ENODE \
  --network-id 10 \
  --p2p-port=61303 \
  --rpc-http-port=12545 \
  --rpc-http-enabled \
  --rpc-http-api=ETH,NET,CLIQUE \
  --host-allowlist="*" \
  --rpc-http-cors-origins="all"