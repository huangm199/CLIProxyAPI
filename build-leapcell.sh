#!/usr/bin/env sh
set -eu

VERSION="${VERSION:-leapcell}"
COMMIT="${COMMIT:-unknown}"
BUILD_DATE="${BUILD_DATE:-$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || printf '%s' unknown)}"

echo "Building CLIProxyAPI for Leapcell"
echo "  VERSION=${VERSION}"
echo "  COMMIT=${COMMIT}"
echo "  BUILD_DATE=${BUILD_DATE}"

CGO_ENABLED=0 GOOS=linux go build \
  -trimpath \
  -ldflags="-s -w -X main.Version=${VERSION} -X main.Commit=${COMMIT} -X main.BuildDate=${BUILD_DATE}" \
  -o CLIProxyAPI \
  ./cmd/server/

echo "Build finished: ./CLIProxyAPI"
