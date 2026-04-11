#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: $0 <key> [.env-override]" >&2
  echo "  .env-override: basename like .env.staging under tools/env, or absolute path." >&2
  exit 1
fi

ENV_DIR="$(env_scripts_tools_env_dir "${BASH_SOURCE[0]}")"
KEY="$1"
OVERRIDE="${2:-}"

env_scripts_require_valid_override_or_die "$OVERRIDE" || exit 1
if ! ENV_PATH="$(env_scripts_resolve_existing_env_path_or_die "$ENV_DIR" "$OVERRIDE")"; then exit 1; fi
if ! DOTENVX="$(env_scripts_dotenvx_bin_or_die "$ENV_DIR")"; then exit 1; fi

exec "$DOTENVX" get "$KEY" -f "$ENV_PATH"
