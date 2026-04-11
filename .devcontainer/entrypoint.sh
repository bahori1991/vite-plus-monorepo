#!/bin/sh
set -eu

# 名前付きボリュームは初回 root 所有になりがちなので、起動のたびに appuser に揃える
mkdir -p /home/appuser/.pnpm-store
chown -R appuser:appuser /home/appuser/.pnpm-store

exec gosu appuser dumb-init -- "$@"
