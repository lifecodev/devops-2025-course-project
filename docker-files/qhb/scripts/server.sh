#!/bin/bash
set -eu

function create_user() {
  useradd "$USER"
}

if ! id -u "$USER" 2> /dev/null; then
   create_user
fi

chown "$USER" "${PGDATA}" "${DB_SOCKETS_PATH}"

runuser -u "$USER" -- /run.sh