#!/usr/bin/env bash
set -euo pipefail

API_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$API_DIR"

case "${NODE_ENV:-development}" in
  production) ENV_FILE=".env.production" ;;
  *) ENV_FILE=".env.development" ;;
esac

if [ -n "${ROOT_PATH:-}" ] && [ -d "${ROOT_PATH}/tools/env" ]; then
  ROOT_DIR="$(cd "${ROOT_PATH}" && pwd)"
else
  ROOT_DIR="$(cd "$API_DIR/../.." && pwd)"
fi

ENV_DIR="$ROOT_DIR/tools/env"

if [ ! -f "$ENV_DIR/$ENV_FILE" ]; then
  echo "Error: env file not found: $ENV_DIR/$ENV_FILE" >&2
  exit 1
fi

DOTENVX="${ENV_DIR}/node_modules/.bin/dotenvx"
if [ ! -x "$DOTENVX" ]; then
  echo "Error: dotenvx not found at $DOTENVX (pnpm install?)" >&2
  exit 1
fi

exec "$DOTENVX" run \
    -f "${ENV_DIR}/${ENV_FILE}" \
    -- vp dev
