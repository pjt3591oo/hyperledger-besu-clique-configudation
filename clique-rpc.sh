# 제안취소
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_discard","params":["0xf7c4bae784079515f38427823fe584d4cd391762"], "id":1}' localhost:8545


# signes 목록조회
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_getSigners","params":["latest"], "id":1}' localhost:8545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_getSigners","params":["latest"], "id":1}' localhost:9545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_getSigners","params":["latest"], "id":1}' localhost:10545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_getSigners","params":["latest"], "id":1}' localhost:11545


# signer metrics 조회(start block, end block)
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_getSignerMetrics","params":["1", "600"], "id":1}' http://127.0.0.1:8545


# 특정 블록에서 등록된 signers 조회(블록 해시)
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_getSignersAtHash","params":["0x2d701c27e0b240a265a7416e309cf4a9131efd45202e6fe8193fcfee8186c4a6"], "id":1}' http://127.0.0.1:8545


# 노드의 제안된 목록
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_proposals","params":[], "id":1}' localhost:8545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_proposals","params":[], "id":1}' localhost:9545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_proposals","params":[], "id":1}' localhost:10545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_proposals","params":[], "id":1}' localhost:11545


# signer 등록/제거 제안 ( address, proposal - true: 등록, false: 제거)
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_propose","params":["0xf7c4bae784079515f38427823fe584d4cd391762", true], "id":1}' localhost:8545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_propose","params":["0xf7c4bae784079515f38427823fe584d4cd391762", true], "id":1}' localhost:9545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_propose","params":["0xf7c4bae784079515f38427823fe584d4cd391762", true], "id":1}' localhost:10545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_propose","params":["0xd10671f5842c30d5613706b67e668d33a6f2ad63", true], "id":1}' localhost:11545


curl -X POST --data '{"jsonrpc":"2.0","method":"clique_propose","params":["0xf7c4bae784079515f38427823fe584d4cd391762", false], "id":1}' localhost:8545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_propose","params":["0xf7c4bae784079515f38427823fe584d4cd391762", false], "id":1}' localhost:9545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_propose","params":["0xf7c4bae784079515f38427823fe584d4cd391762", false], "id":1}' localhost:10545
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_propose","params":["0xd10671f5842c30d5613706b67e668d33a6f2ad63", false], "id":1}' localhost:11545
