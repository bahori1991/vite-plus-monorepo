#!/bin/sh
set -eu

mkdir -p /home/appuser/.pnpm-store
chown -R appuser:appuser /home/appuser/.pnpm-store

exec gosu appuser dumb-init -- "$@"
