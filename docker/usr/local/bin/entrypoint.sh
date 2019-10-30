#!/bin/bash
set -e

function install_templates() {
    # wait until ES is up
    until $(curl -o /dev/null -s -H 'Content-Type: application/json' --fail "http://localhost:9200"); do
        echo "Waiting for ES to start..."
        sleep 5
    done

    curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/_template/dot-kibana' -d @/$1
}

echo "starting"

install_templates "template_kibana.json" &

exec /usr/local/bin/docker-entrypoint.sh "$@"
