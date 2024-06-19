#!/bin/bash

CHAIN_ID_DEFAULT=10
BLOCK_PERIOD_SECONDS_DEFAULT=2
CREATE_EMPTY_BLOCKS_DEFAULT='YES'
EPOCH_LENGTH_DEFAULT=30000
SIGNER_SELECT_DEFAULT='1,2,3'



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
  
  node_indexs=($1 $2 $3 $4 $5)
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

extraData=$(getExtraData 1 2 3 4 5 | tr -d '\n')

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
    "394B4E49448dfe7753d141C13B05feeFa98b1399": {
      "privateKey": "99afd5cb7bb89975bf4f8a8de49a9b798298db5de5881482de8b21c4241394f1",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "0xad78ebc5ac6200000"
    },
    "eA3ca46f74AA190dEDc965d41999908A1C93544e": {
      "privateKey": "c7dddc347a4795321b77bc751f6596f341bdac582916ed812a464ada2128e2c1",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "90000000000000000000000"
    },
    "b54C13fbf4529ab7a131eBbed222D1Dd29191c9f": {
      "privateKey": "da6820d49c5198f079cd65749be8268ba6aac645a3de18ff9b14a4ac04f20975",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "90000000000000000000000"
    },
    "A7f9216B9877B5aEeF21d488fF4f40bbe9E39c34": {
      "privateKey": "997c21aa7b6303b3abcc5f6ffed1c1ce4a5f5c03d511111ed637508cf22b9fa7",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "0xad78ebc5ac6200000"
    },
    "21E56785C9fbf281D4DfB9dbb2198d5688F4a471": {
      "privateKey": "460c5bb9a3f07f729821139fc1057ff3ba6b362589b7da76c6bd58b4ee516222",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "90000000000000000000000"
    },
    "3Dbf1cfF1AFf98675E7401373c1984F39C096770": {
      "privateKey": "996981d1cce5dd77cce3df50e1e77127afc9aa75d50abd48ebd8b098a12e5ec1",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "90000000000000000000000"
    },
    "46B2447eB8fE25f14dfd87C9FB3B16133d5a27e9": {
      "privateKey": "39dc4aadba04cd23ee413f8a6b3f191bbb15a80c3ab55b966200e2a4f59b9170",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "0xad78ebc5ac6200000"
    },
    "Ab3FfE2213e629DC5Bdde7283F0A2Bc0128A5acd": {
      "privateKey": "e20e0200c2fb1eca38ddf3985fac10b747015cd985d4ff56bbc36d03d30c1b5a",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "90000000000000000000000"
    },
    "446EFF460550a45D0581FBd3b1Fb456b0442EB84": {
      "privateKey": "7b68edaf8d4e0002a8456ff375f420e544fab8dedcf41f4948dec00f1ab0145e",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "90000000000000000000000"
    },
    "7C6F7576bD2F85DDAC25A2c4fcFAD53c638Cc9c1": {
      "privateKey": "aebea620e3b5f5085de9017d56ef37088578b2b03f6315f7427eee79ce53dc46",
      "comment": "private key and this comment are ignored.  In a real chain, the private key should NOT be stored",
      "balance": "90000000000000000000000"
    },
    "0000000000FFe8B47B3e2130213B802212439497": {
      "comment": "IMMUTABLE_CREATE2_FACTORY",
      "balance": "0x10",
      "code": "60806040526004361061003f5760003560e01c806308508b8f1461004457806364e030871461009857806385cf97ab14610138578063a49a7c90146101bc575b600080fd5b34801561005057600080fd5b506100846004803603602081101561006757600080fd5b503573ffffffffffffffffffffffffffffffffffffffff166101ec565b604080519115158252519081900360200190f35b61010f600480360360408110156100ae57600080fd5b813591908101906040810160208201356401000000008111156100d057600080fd5b8201836020820111156100e257600080fd5b8035906020019184600183028401116401000000008311171561010457600080fd5b509092509050610217565b6040805173ffffffffffffffffffffffffffffffffffffffff9092168252519081900360200190f35b34801561014457600080fd5b5061010f6004803603604081101561015b57600080fd5b8135919081019060408101602082013564010000000081111561017d57600080fd5b82018360208201111561018f57600080fd5b803590602001918460018302840111640100000000831117156101b157600080fd5b509092509050610592565b3480156101c857600080fd5b5061010f600480360360408110156101df57600080fd5b508035906020013561069e565b73ffffffffffffffffffffffffffffffffffffffff1660009081526020819052604090205460ff1690565b600083606081901c33148061024c57507fffffffffffffffffffffffffffffffffffffffff0000000000000000000000008116155b6102a1576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260458152602001806107746045913960600191505060405180910390fd5b606084848080601f0160208091040260200160405190810160405280939291908181526020018383808284376000920182905250604051855195965090943094508b93508692506020918201918291908401908083835b6020831061033557805182527fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe090920191602091820191016102f8565b51815160209384036101000a7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff018019909216911617905260408051929094018281037fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe00183528085528251928201929092207fff000000000000000000000000000000000000000000000000000000000000008383015260609890981b7fffffffffffffffffffffffffffffffffffffffff00000000000000000000000016602183015260358201969096526055808201979097528251808203909701875260750182525084519484019490942073ffffffffffffffffffffffffffffffffffffffff81166000908152938490529390922054929350505060ff16156104a7576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040180806020018281038252603f815260200180610735603f913960400191505060405180910390fd5b81602001825188818334f5955050508073ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff161461053a576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260468152602001806107b96046913960600191505060405180910390fd5b50505073ffffffffffffffffffffffffffffffffffffffff8116600090815260208190526040902080547fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff001660011790559392505050565b6000308484846040516020018083838082843760408051919093018181037fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe001825280845281516020928301207fff000000000000000000000000000000000000000000000000000000000000008383015260609990991b7fffffffffffffffffffffffffffffffffffffffff000000000000000000000000166021820152603581019790975260558088019890985282518088039098018852607590960182525085519585019590952073ffffffffffffffffffffffffffffffffffffffff81166000908152948590529490932054939450505060ff909116159050610697575060005b9392505050565b604080517fff000000000000000000000000000000000000000000000000000000000000006020808301919091523060601b6021830152603582018590526055808301859052835180840390910181526075909201835281519181019190912073ffffffffffffffffffffffffffffffffffffffff81166000908152918290529190205460ff161561072e575060005b9291505056fe496e76616c696420636f6e7472616374206372656174696f6e202d20636f6e74726163742068617320616c7265616479206265656e206465706c6f7965642e496e76616c69642073616c74202d206669727374203230206279746573206f66207468652073616c74206d757374206d617463682063616c6c696e6720616464726573732e4661696c656420746f206465706c6f7920636f6e7472616374207573696e672070726f76696465642073616c7420616e6420696e697469616c697a6174696f6e20636f64652ea265627a7a723058202bdc55310d97c4088f18acf04253db593f0914059f0c781a9df3624dcef0d1cf64736f6c634300050a0032"
    }      
  },
  "number": "0x0",
  "gasUsed": "0x0",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000"
}
EOF
)

echo "$json_content" > genesis.json