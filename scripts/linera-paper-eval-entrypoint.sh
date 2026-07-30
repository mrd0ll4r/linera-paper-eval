#!/usr/bin/env bash
set -euo pipefail

. $(dirname "$0")/set_up_node_and_wallet.sh

echo "==> Wallet"
linera wallet show

echo "==> Running eval binary"

RUST_LOG="info,linera_paper_eval=info" /usr/local/bin/linera-paper-eval

echo "==> Done"
