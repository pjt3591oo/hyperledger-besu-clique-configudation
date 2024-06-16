./remove.sh

NODE_1_DIR=node-1
NODE_2_DIR=node-2
NODE_3_DIR=node-3
NODE_4_DIR=node-4

mkdir -p $NODE_1_DIR/data
mkdir -p $NODE_2_DIR/data
mkdir -p $NODE_3_DIR/data
mkdir -p $NODE_4_DIR/data

besu --data-path=$NODE_1_DIR/data public-key export-address --to=$NODE_1_DIR/data/node1Address
besu --data-path=$NODE_2_DIR/data public-key export-address --to=$NODE_2_DIR/data/node2Address
besu --data-path=$NODE_3_DIR/data public-key export-address --to=$NODE_3_DIR/data/node3Address
besu --data-path=$NODE_4_DIR/data public-key export-address --to=$NODE_4_DIR/data/node4Address