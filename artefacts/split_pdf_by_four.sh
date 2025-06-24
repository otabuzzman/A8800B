#!/bin/bash

qpdf || exit $?

INPUT="$1"

TOTAL_PAGES=$(qpdf --show-npages "$INPUT")

START=1
BLOCK=4
FILE_IDX=1

while [ "$START" -le "$TOTAL_PAGES" ]; do
  END=$((START + BLOCK - 1))
  if [ "$END" -gt "$TOTAL_PAGES" ]; then
    END="$TOTAL_PAGES"
  fi
  qpdf "$INPUT" --pages "$INPUT" $START-$END -- "part-$(printf "%03d" "$FILE_IDX").pdf"
  echo "Created: $part-$(printf "%03d" "$FILE_IDX").pdf (pages $START to $END)"
  START=$((END + 1))
  FILE_IDX=$((FILE_IDX + 1))
done
