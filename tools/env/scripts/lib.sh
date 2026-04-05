#!/usr/bin/env bash
# Shared helpers for tools/env/scripts/*.sh — use: source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

# $1 = path to the calling script (pass "${BASH_SOURCE[0]}")
env_scripts_resolve_root_dir() {
  local caller_script="$1"
  if [ -n "${ROOT_PATH:-}" ] && [ -d "${ROOT_PATH}/tools/env" ]; then
    cd "${ROOT_PATH}" && pwd
    return
  fi
  local script_path="$caller_script"
  case "$script_path" in
    /*) ;;
    *) script_path="$(pwd)/${script_path#./}" ;;
  esac
  cd "$(dirname "$script_path")/../../.." && pwd
}

env_scripts_default_env_basename() {
  case "${NODE_ENV:-development}" in
    production) echo ".env.production" ;;
    *) echo ".env.development" ;;
  esac
}

# Optional override: basename .env* under tools/env, or absolute path to an env file.
env_scripts_is_env_override() {
  local a="${1:-}"
  [[ "$a" =~ ^\.env ]] && return 0
  [[ "$a" == /* ]] && [[ "$a" =~ /\.env ]] && return 0
  return 1
}

# $1 = ENV_DIR, $2 = optional override token (or empty for default)
env_scripts_resolve_env_path() {
  local env_dir="$1"
  local token="${2:-}"
  if [ -z "$token" ]; then
    echo "${env_dir}/$(env_scripts_default_env_basename)"
    return
  fi
  if [[ "$token" == /* ]]; then
    echo "$token"
    return
  fi
  if env_scripts_is_env_override "$token"; then
    echo "${env_dir}/${token}"
    return
  fi
  echo ""
}
