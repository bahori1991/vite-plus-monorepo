#!/usr/bin/env bash
# アプリ（apps/<name>）の cwd で dotenvx を通して vp dev を起動する。
# tools/env から pnpm タスクで cwd がずれると TanStack / Vite が誤ったパスを見るため、必ずアプリ直下で実行する。
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

APP_NAME="${1:-}"
if [ -z "$APP_NAME" ] || [[ "$APP_NAME" == -* ]]; then
  echo "Usage: $0 <web|api>" >&2
  exit 1
fi

ROOT_DIR="$(env_scripts_resolve_root_dir "${BASH_SOURCE[0]}")"
ENV_DIR="${ROOT_DIR}/tools/env"
ENV_FILE="$(env_scripts_default_env_basename)"
APP_DIR="${ROOT_DIR}/apps/${APP_NAME}"

if [ ! -d "$APP_DIR" ]; then
  echo "Error: app directory not found: $APP_DIR" >&2
  exit 1
fi

if [ ! -f "${ENV_DIR}/${ENV_FILE}" ]; then
  echo "Error: env file not found: ${ENV_DIR}/${ENV_FILE}" >&2
  exit 1
fi

if ! DOTENVX="$(env_scripts_dotenvx_bin_or_die "$ENV_DIR")"; then exit 1; fi

cd "$APP_DIR"
# pnpm --filter @tools/env exec は cwd が tools/env になり、-c vite.config.ts が誤解決される。
# アプリ直下の cwd を保つため dotenvx を直接呼ぶ。
# モノレポでは vp dev がルートの vite.config を優先しがちなので、設定ファイルは絶対パスで渡す。
exec "$DOTENVX" run \
  -f "${ENV_DIR}/${ENV_FILE}" \
  -- vp dev -c "${APP_DIR}/vite.config.ts"
