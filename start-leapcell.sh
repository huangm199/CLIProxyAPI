#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

export DEPLOY="${DEPLOY:-cloud}"
export WRITABLE_PATH="${WRITABLE_PATH:-/tmp}"
export TZ="${TZ:-Asia/Shanghai}"

mkdir -p "${WRITABLE_PATH}" "${WRITABLE_PATH}/.cli-proxy-api"

if [ ! -f "${ROOT_DIR}/CLIProxyAPI" ]; then
  echo "Missing binary: ${ROOT_DIR}/CLIProxyAPI"
  echo "Run the build step first."
  exit 1
fi

if [ ! -f "${ROOT_DIR}/config.leapcell.yaml" ]; then
  echo "Missing config: ${ROOT_DIR}/config.leapcell.yaml"
  exit 1
fi

exec "${ROOT_DIR}/CLIProxyAPI" -config "${ROOT_DIR}/config.leapcell.yaml"
