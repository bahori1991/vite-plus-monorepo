#!/usr/bin/env bash
set -euo pipefail

case "${NODE_ENV:-development}" in
  production) ENV_FILE=".env.production" ;;
  *) ENV_FILE=".env.development" ;;
esac

# Prefer ROOT_PATH from the environment (e.g. Dev Container) so cwd/script path quirks do not matter.
if [ -n "${ROOT_PATH:-}" ] && [ -d "${ROOT_PATH}/tools/env" ]; then
  ROOT_DIR="$(cd "${ROOT_PATH}" && pwd)"
else
  SCRIPT_PATH="${BASH_SOURCE[0]}"
  case "$SCRIPT_PATH" in
    /*) ;;
    *) SCRIPT_PATH="$(pwd)/${SCRIPT_PATH#./}" ;;
  esac
  # This file is <repo>/tools/env/scripts/run.sh → repo root is three levels above the script dir.
  ROOT_DIR="$(cd "$(dirname "$SCRIPT_PATH")/../../.." && pwd)"
fi

ENV_DIR="$ROOT_DIR/tools/env"

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <command...>" >&2
  exit 1
fi

if [ ! -f "$ENV_DIR/$ENV_FILE" ]; then
  echo "Error: env file not found: $ENV_DIR/$ENV_FILE" >&2
  exit 1
fi

pnpm --filter @repo/env exec dotenvx run \
  -f "${ENV_DIR}/${ENV_FILE}" \
  -- "$@"
