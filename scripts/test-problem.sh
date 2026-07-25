#!/bin/bash
# Usage: ./scripts/test-problem.sh abc360 a
# Builds and runs sample testcases

CONTEST=$1
TASK=$2

if [ -z "$CONTEST" ] || [ -z "$TASK" ]; then
  echo "Usage: $0 <contest> <task>"
  echo "Example: $0 abc360 a"
  exit 1
fi

EXEC_NAME="$CONTEST-$TASK"
TEST_DIR="testcase/$CONTEST/$TASK/test"

echo "=== Building $EXEC_NAME ==="
cabal build "$EXEC_NAME" --project-file=cabal.project || exit 1

EXEC_PATH=$(cabal list-bin "$EXEC_NAME" --project-file=cabal.project 2>/dev/null)

if [ -d "$TEST_DIR" ]; then
  echo "=== Running tests ==="
  oj test -c "$EXEC_PATH" -d "$TEST_DIR"
else
  echo "No testcases at $TEST_DIR"
  echo "Run: ./scripts/dl-testcase.sh $CONTEST $TASK"
  echo ""
  echo "=== Manual test (enter input, Ctrl-D to end) ==="
  "$EXEC_PATH"
fi
