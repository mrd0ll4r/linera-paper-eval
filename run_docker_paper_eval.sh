#!/usr/bin/env bash
set -euo pipefail

rm -rf data_out
mkdir -p data_out

docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 1 --shards 1" -e EXPERIMENT_CONFIGURATION="validators=1_shards=1" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 2 --shards 1" -e EXPERIMENT_CONFIGURATION="validators=2_shards=1" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 4 --shards 1" -e EXPERIMENT_CONFIGURATION="validators=4_shards=1" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 8 --shards 1" -e EXPERIMENT_CONFIGURATION="validators=8_shards=1" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval

docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 1 --shards 2" -e EXPERIMENT_CONFIGURATION="validators=1_shards=2" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 2 --shards 2" -e EXPERIMENT_CONFIGURATION="validators=2_shards=2" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 4 --shards 2" -e EXPERIMENT_CONFIGURATION="validators=4_shards=2" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 8 --shards 2" -e EXPERIMENT_CONFIGURATION="validators=8_shards=2" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval

docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 1 --shards 4" -e EXPERIMENT_CONFIGURATION="validators=1_shards=4" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 2 --shards 4" -e EXPERIMENT_CONFIGURATION="validators=2_shards=4" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 4 --shards 4" -e EXPERIMENT_CONFIGURATION="validators=4_shards=4" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 8 --shards 4" -e EXPERIMENT_CONFIGURATION="validators=8_shards=4" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval

docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 1 --shards 8" -e EXPERIMENT_CONFIGURATION="validators=1_shards=8" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 2 --shards 8" -e EXPERIMENT_CONFIGURATION="validators=2_shards=8" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 4 --shards 8" -e EXPERIMENT_CONFIGURATION="validators=4_shards=8" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
docker run -it --rm -e EXPERIMENT_REPETITION="1" -e LINERA_NET_UP_OPTIONS="--initial-amount 1000000000 --validators 8 --shards 8" -e EXPERIMENT_CONFIGURATION="validators=8_shards=8" -v ./data_out:/data_out -v /media/ramdisk:/ramdisk linera-paper-eval
