#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

ROOT_DIR="$(env_scripts_resolve_root_dir "${BASH_SOURCE[0]}")"
ENV_DIR="$ROOT_DIR/tools/env"

if [ "$#" -gt 1 ]; then
  echo "Usage: $0 [.env-override]" >&2
  echo "  .env-override: basename like .env.staging under tools/env, or absolute path." >&2
  exit 1
fi

if [ "$#" -eq 1 ]; then
  if ! env_scripts_is_env_override "$1"; then
    echo "Error: override must be a .env* basename or an absolute path containing /.env" >&2
    exit 1
  fi
  ENV_PATH="$(env_scripts_resolve_env_path "$ENV_DIR" "$1")"
else
  ENV_PATH="$(env_scripts_resolve_env_path "$ENV_DIR" "")"
fi

if [ -z "$ENV_PATH" ]; then
  echo "Error: could not resolve env file path." >&2
  exit 1
fi

if [ ! -f "$ENV_PATH" ]; then
  echo "Error: env file not found: $ENV_PATH" >&2
  exit 1
fi

pnpm --filter @repo/env exec dotenvx encrypt -f "$ENV_PATH"
