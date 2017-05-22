#!/usr/bin/env bash

GOLD='\e[6;33m'
NC='\e[0m' # No Color

function log {
    echo -ne "${GOLD}$@${NC}\n"
}

PROGRAM_NAME=$(echo $1 | grep -oP "[^/]*$")
TARBALL_FILE="standalone.tar.gz"
TMP_DIR=$(mktemp -d)
MAIN_DIR="$TMP_DIR/standalone"

mkdir $MAIN_DIR
mkdir $MAIN_DIR/lib

echo -e "#!/usr/bin/env bash
BASEDIR=\$(dirname \$0)
export LD_LIBRARY_PATH=\$BASEDIR/lib:\$LD_LIBRARY_PATH
\$BASEDIR/$PROGRAM_NAME \$@" > $MAIN_DIR/run.sh

chmod +x $MAIN_DIR/run.sh

echo -e "#!/usr/bin/env bash
BASEDIR=\$(dirname \$0)
export LD_LIBRARY_PATH=\$BASEDIR/lib:\$LD_LIBRARY_PATH

rm -rf \$BASEDIR/lib; mkdir \$BASEDIR/lib;

while true; do
  NOT_FOUND_LIBS=\$(
    ldd \$BASEDIR/$PROGRAM_NAME \\
      | grep \"not found\" \\
      | grep -oP '(^[^ ]+)' \\
  )
  if [ -z \"\$NOT_FOUND_LIBS\" ]; then
    break
  fi
  echo \$NOT_FOUND_LIBS \\
    | grep -oP '([^ ]+)' \\
    | xargs -i -n 1 cp \$BASEDIR/lib_bkp/{} \$BASEDIR/lib
done" > $MAIN_DIR/configure.sh

chmod +x $MAIN_DIR/configure.sh

log "copying dinamyc libraries..."
ldd $1 \
    | grep "=>" \
    | grep -oP '(\/[^ ]+)' \
    | xargs -i -n 1 cp {} $MAIN_DIR/lib_bkp

log "copying binary..."
cp $1 $MAIN_DIR

log "creating tarball..."
tar -zcf $TARBALL_FILE -C $TMP_DIR .

rm -rf $TMP_DIR

log "done."
