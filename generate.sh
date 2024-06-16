#!/bin/bash

CHAIN_ID_DEFAULT=10
BLOCK_PERIOD_SECONDS_DEFAULT=2
CREATE_EMPTY_BLOCKS_DEFAULT='YES'
EPOCH_LENGTH_DEFAULT=30000
SIGNER_SELECT_DEFAULT='1,2'



function getChainId() {
  read -p "chain id? (default: $CHAIN_ID_DEFAULT)" chainid
  if [ -z "$chainid" ]; then
    chainid=$CHAIN_ID_DEFAULT
  fi

  echo $chainid
}


function getCreateEmptyBlocks() {
  read -p "is create empty block? (yes or no, default: $CREATE_EMPTY_BLOCKS_DEFAULT)" createemptyblocks
  if [ -z "$createemptyblocks" ]; then
    echo true
    return
  fi

  if [ "$createemptyblocks" == "yes" ]; then
    echo true
  else
    echo false
  fi
}

function getEpochLength() {
  read -p "epoch length? (default: 30,000)" epochlength
  if [ -z "$epochlength" ]; then
    epochlength=$EPOCH_LENGTH_DEFAULT
  fi
  
  echo $epochlength
}

function getBlockPeriodSeconds() {
  read -p "block period seconds? (default: $BLOCK_PERIOD_SECONDS_DEFAULT)" blockperiodseconds
  if [ -z "$blockperiodseconds" ]; then
    blockperiodseconds=$BLOCK_PERIOD_SECONDS_DEFAULT
  fi
  
  echo $blockperiodseconds
}

function getExtraData() {
  
  node_indexs=($1 $2 $3 $4)
  index=1

  echo ""
  echo ""

  # show
  for node_index in ${node_indexs[@]}; do
    printf "[%d] node-%d: %s\n" $index $node_index $(cat node-[$node_index]/data/node[$node_index]Address) >&2
    index=$((index+1))
  done

  # select
  read -p "signer select (default: $SIGNER_SELECT_DEFAULT)" signer_index
  if [ -z "$signer_index" ]; then
    signer_index=$SIGNER_SELECT_DEFAULT
  fi

  # extract signer address
  select_signers=($(echo $signer_index | tr "," "\n"))
  signers=''

  for node_index in ${select_signers[@]}; do
    signer_address="$(cat node-[$node_index]/data/node[$node_index]Address)"
    signers+="$(echo "${signer_address:2}")"
  done

  extra_data_head=0x0000000000000000000000000000000000000000000000000000000000000000
  extra_data_tail=0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
  
  echo $extra_data_head$signers$extra_data_tail
}

chainId=$(getChainId | tr -d '\n')
createemptyblocks=$(getCreateEmptyBlocks | tr -d '\n')
epochlength=$(getEpochLength | tr -d '\n')
blockperiodseconds=$(getBlockPeriodSeconds | tr -d '\n')

extraData=$(getExtraData 1 2 3 4 | tr -d '\n')

echo ""
echo ""
echo '============== result ================'
echo chainId: $chainId
echo createemptyblocks: $createemptyblocks
echo epochlength: $epochlength
echo blockperiodseconds: $blockperiodseconds
echo extraData: $extraData
echo '=============================='


json_content=$(cat <<EOF
{
  "config": {
    "chainId": $chainId,
    "berlinBlock": 0,
    "londonBlock": 0,
    "zeroBaseFee": true,
    "clique": {
      "blockperiodseconds": $blockperiodseconds,
      "epochlength": $epochlength,
      "createemptyblocks": $createemptyblocks
    }
  },
  "coinbase": "0x0000000000000000000000000000000000000000",
  "difficulty": "0x1",
  "extraData": "$extraData",
  "gasLimit": "0x1fffffffffffff",
  "mixHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "nonce": "0x0",
  "timestamp": "0x5c51a607",
  "alloc": {
    "fe3b557e8fb62b89f4916b721be55ceb828dbd73": {
      "privateKey": "8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "0xad78ebc5ac6200000"
    },
    "627306090abaB3A6e1400e9345bC60c78a8BEf57": {
      "privateKey": "c87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "90000000000000000000000"
    },
    "f17f52151EbEF6C7334FAD080c5704D77216b732": {
      "privateKey": "ae6ae8e5ccbfb04590405997ee2d52d2b330726137b875053c36d94e974d162f",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "90000000000000000000000"
    }
  },
  "number": "0x0",
  "gasUsed": "0x0",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000"
}
EOF
)

echo "$json_content" > genesis.json