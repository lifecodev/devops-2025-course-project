#!/usr/bin/env bash
set -eu

echo "PGDATA: ${PGDATA}"

if [ ! -f "${PGDATA}/qhb.conf" ]; then
    echo "Initializing database at ${PGDATA}"
    if ! initdb --encoding=UTF8; then
        echo "Failed to initialize database"
        /bin/bash
        exit 1
    fi

    echo "\
      port = 5432
      listen_addresses = '*'
      unix_socket_directories = '$DB_SOCKETS_PATH'
      max_connections = 1000
      log_error_verbosity = default
      log_checkpoint_progress = on
      qss_mode = 0
      use_qhb_cache = false
      shared_buffers = 1GB
      shared_buffers_partitions = 128
      qhb_cache_size = 48MB
      " | tee -a "${PGDATA}/qhb.conf"

    echo "host all all 0.0.0.0/0 trust" | tee -a "${PGDATA}/qhb_hba.conf"
    create_database=1
else
    echo "Found existing database at ${PGDATA}"
    create_database=0
fi

ulimit -u 100000
echo "Starting database"
if ! qhb_ctl start -t 10000; then
    echo "qhb_ctl failed"
    /bin/bash
    exit 1
fi

if [ "$create_database" -eq 1 ]; then
    echo "Creating database"

    if ! createdb --host "$DB_SOCKETS_PATH"; then
        echo "createdb failed"
        /bin/bash
        exit 1
    fi

    echo "Database created"
fi

echo "Ready to accept connections"

tail -f /dev/null
