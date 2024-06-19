
node_info=$(curl -s --location --globoff 'http://localhost:8545' \
    --data '{
        "jsonrpc": "2.0",
        "method": "admin_nodeInfo",
        "params": [],
        "id": 1
    }' | jq -r '.result.id')

NODE_1_ENODE=enode://$node_info@localhost:30303
echo $node_info
echo $NODE_1_ENODE