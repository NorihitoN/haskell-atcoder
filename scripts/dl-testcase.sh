#!/bin/bash
# Usage: ./scripts/dl-testcase.sh abc360 a
# Downloads sample testcases using oj

CONTEST=$1
TASK=$2

if [ -z "$CONTEST" ] || [ -z "$TASK" ]; then
  echo "Usage: $0 <contest> <task>"
  echo "Example: $0 abc360 a"
  exit 1
fi

DIR="testcase/$CONTEST/$TASK"
mkdir -p "$DIR"
cd "$DIR"

URL="https://atcoder.jp/contests/$CONTEST/tasks/${CONTEST}_${TASK}"
echo "Downloading testcases from: $URL"
oj dl "$URL"
