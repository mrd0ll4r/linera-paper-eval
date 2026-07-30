#!/usr/bin/env bash
set -euo pipefail

BUILD_PROFILE="${BUILD_PROFILE:-release}"

case "${BUILD_PROFILE}" in
  release)
    CARGO_PROFILE_FLAG="--release"
    TARGET_DIR="release"
    ;;
  debug)
    CARGO_PROFILE_FLAG=""
    TARGET_DIR="debug"
    ;;
  *)
    echo "Unsupported BUILD_PROFILE: ${BUILD_PROFILE}" >&2
    echo "Expected 'release' or 'debug'." >&2
    exit 1
    ;;
esac

docker buildx build \
  -f Dockerfile.linera-paper-eval-builder-base \
  --build-arg TARGET_DIR="$TARGET_DIR" \
  --build-arg CARGO_PROFILE_FLAG="$CARGO_PROFILE_FLAG" \
  -t linera-paper-eval-builder-base .

docker buildx build \
  -f Dockerfile.linera-paper-eval \
  -t linera-paper-eval \
  --build-arg TARGET_DIR="$TARGET_DIR" \
  --build-arg CARGO_PROFILE_FLAG="$CARGO_PROFILE_FLAG" \
  --load .
