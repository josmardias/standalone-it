#!/usr/bin/env bash

GOLD='\e[6;33m'
NC='\e[0m' # No Color

function log {
    echo -ne "${GOLD}$@${NC}\n"
}

TARBALL_FILE="standalone.tar.gz"
TMP_DIR=$(mktemp -d)

log "copying dinamyc libraries..."
ldd $1 \
    | grep "=>" \
    | grep -oP '(\/[^ ]+)' \
    | xargs -i -n 1 cp {} $TMP_DIR

log "copying binary..."
cp $1 $TMP_DIR

log "creating tarball..."
tar -zcf $TARBALL_FILE -C $TMP_DIR .

rm -rf $TMP_DIR

log "done."

