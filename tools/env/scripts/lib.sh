#!/usr/bin/env bash
# Shared helpers for tools/env/scripts/*.sh — use: source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

# $1 = path to the calling script (pass "${BASH_SOURCE[0]}")
# Prints absolute repo root; does not change the caller's working directory.
env_scripts_resolve_root_dir() {
  local caller_script="$1"
  if [ -n "${ROOT_PATH:-}" ] && [ -d "${ROOT_PATH}/tools/env" ]; then
    (cd "${ROOT_PATH}" && pwd) || return 1
    return 0
  fi
  local script_path="$caller_script"
  case "$script_path" in
    /*) ;;
    *) script_path="$(pwd)/${script_path#./}" ;;
  esac
  (cd "$(dirname "$script_path")/../../.." && pwd) || return 1
}

# $1 = "${BASH_SOURCE[0]}"
env_scripts_tools_env_dir() {
  local root
  root="$(env_scripts_resolve_root_dir "$1")" || return 1
  echo "${root}/tools/env"
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

# $1 = optional override token (empty skips validation)
env_scripts_require_valid_override_or_die() {
  local token="${1:-}"
  [ -z "$token" ] && return 0
  if ! env_scripts_is_env_override "$token"; then
    echo "Error: override must be a .env* basename or an absolute path containing /.env" >&2
    return 1
  fi
}

# $1 = ENV_DIR, $2 = optional override token (empty = default env file)
# Prints absolute path to an existing env file, or prints an error and returns non-zero.
env_scripts_resolve_existing_env_path_or_die() {
  local env_dir="$1"
  local token="${2:-}"
  local path
  path="$(env_scripts_resolve_env_path "$env_dir" "$token")"
  if [ -z "$path" ]; then
    echo "Error: could not resolve env file path." >&2
    return 1
  fi
  if [ ! -f "$path" ]; then
    echo "Error: env file not found: $path" >&2
    return 1
  fi
  echo "$path"
}

# $1 = ENV_DIR (…/tools/env)
# Prints path to dotenvx binary, or prints an error and returns non-zero.
env_scripts_dotenvx_bin_or_die() {
  local env_dir="$1"
  local bin="${env_dir}/node_modules/.bin/dotenvx"
  if [ ! -x "$bin" ]; then
    echo "Error: dotenvx not found at $bin (pnpm install?)" >&2
    return 1
  fi
  echo "$bin"
}
