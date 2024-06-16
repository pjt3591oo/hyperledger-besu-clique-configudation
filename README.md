# hyperledger besu clique configuration

node-1, node-2, node-3, node-4

### init

```bash
$ setup.sh
```

### generate genesis

```bash
$ generate.sh
```

### run node

```bash
$ ./node-1.start.sh
```

RPC PORT: 8545
P2P PORT: 30303

```bash
export NODE_1_ENODE=<node1 enode>
$ ./node-2.start.sh
```

RPC PORT: 9545
P2P PORT: 40303

```bash
export NODE_1_ENODE=<node1 enode>
$ ./node-3.start.sh
```

RPC PORT: 10545
P2P PORT: 50303

```bash
export NODE_1_ENODE=<node1 enode>
$ ./node-4.start.sh
```

RPC PORT: 11545
P2P PORT: 60303

### check

```bash
$ ./check.sh
```

```bash
$ ./clique-rpc.sh
```

### remove

```bash
$ remove.sh
```