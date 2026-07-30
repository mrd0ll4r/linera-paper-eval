#!/usr/bin/env bash
set -euo pipefail

. $(dirname "$0")/set_up_node_and_wallet.sh

echo "==> Running benchmark"

export LINERA_KEYSTORE="${LINERA_TMP_DIR}/keystore_1.json"
export LINERA_WALLET="${LINERA_TMP_DIR}/wallet_1.json"

# I have no idea why I need the wallet and keystore from one client and the DB from another...
linera benchmark \
  --storage "rocksdb:${LINERA_TMP_DIR}/client_0.db" \
  single \
  --num-chains 100 \
  --tokens-per-chain 1000 \
  --transactions-per-block 10 \
  --bps 10 \
  --close-chains true \
  --runtime-in-seconds 60

echo "==> Done"
