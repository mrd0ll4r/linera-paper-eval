#!/usr/bin/env bash
set -euo pipefail

# Optional arguments to pass to linera net up
LINERA_NET_UP_OPTIONS="${LINERA_NET_UP_OPTIONS:-}"

export PATH="/usr/local/bin:${PATH}"

export LINERA_APPLICATION_LOGS=true

export FAUCET_PORT="8080"
export FAUCET_URL="http://127.0.0.1:${FAUCET_PORT}"

mkdir -p "/ramdisk/linera"
RUN_DIR="$(mktemp -d -p /ramdisk/linera)"

echo "==> Starting fresh local Linera network"

source /dev/stdin <<<"$(linera net helper 2>/dev/null)"

RUST_LOG="info" linera_spawn \
  linera net up --path "${RUN_DIR}" --with-faucet --faucet-port "${FAUCET_PORT}" ${LINERA_NET_UP_OPTIONS}

echo "==> Waiting for faucet at ${FAUCET_URL}"

for attempt in $(seq 1 60); do
  if curl --fail --silent "${FAUCET_URL}" >/dev/null 2>&1; then
    break
  fi

  if [ "${attempt}" -eq 60 ]; then
    echo "Faucet did not become ready :(" >&2
    exit 1
  fi

  sleep 1
done

echo "==> Initializing wallet"

# TODO these are different from the ones `linera net up` produces, is that a problem?
export LINERA_TMP_DIR="${RUN_DIR}"
export LINERA_WALLET="${RUN_DIR}/wallet.json"
export LINERA_KEYSTORE="${RUN_DIR}/keystore.json"
export LINERA_STORAGE="rocksdb:${RUN_DIR}/wallet-client.db"

linera wallet init --faucet "${FAUCET_URL}"

echo "==> Done setting up the node :)"
