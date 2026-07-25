#!/bin/bash
# Usage: ./scripts/add-problem.sh abc360 a
# Creates the source file and adds the executable to atcoder.cabal

CONTEST=$1
TASK=$2

if [ -z "$CONTEST" ] || [ -z "$TASK" ]; then
  echo "Usage: $0 <contest> <task>"
  echo "Example: $0 abc360 b"
  exit 1
fi

UPPER_TASK=$(echo "$TASK" | tr 'a-z' 'A-Z')
DIR="abc/$CONTEST"
FILE="$DIR/$UPPER_TASK.hs"
EXEC_NAME="$CONTEST-$TASK"

mkdir -p "$DIR"

if [ ! -f "$FILE" ]; then
  cp template/Main.hs "$FILE"
  echo "Created $FILE"
else
  echo "$FILE already exists"
fi

# Check if executable already in cabal file
if grep -q "executable $EXEC_NAME" atcoder.cabal; then
  echo "executable $EXEC_NAME already in atcoder.cabal"
else
  cat >> atcoder.cabal << EOF

executable $EXEC_NAME
  import:         defaults
  hs-source-dirs: $DIR
  main-is:        $UPPER_TASK.hs
  build-depends:  atcoder
EOF
  echo "Added executable $EXEC_NAME to atcoder.cabal"
fi
