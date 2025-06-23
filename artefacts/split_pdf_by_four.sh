#!/bin/bash

# requires `qpdf' (brew install qpdf)

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 input.pdf output_prefix"
  exit 1
fi

INPUT="$1"
PREFIX="$2"

TOTAL_PAGES=$(qpdf --show-npages "$INPUT")

START=1
BLOCK=4
FILE_IDX=1

while [ "$START" -le "$TOTAL_PAGES" ]; do
  END=$((START + BLOCK - 1))
  if [ "$END" -gt "$TOTAL_PAGES" ]; then
    END="$TOTAL_PAGES"
  fi
  qpdf "$INPUT" --pages "$INPUT" $START-$END -- "${PREFIX}_part${FILE_IDX}.pdf"
  echo "Created: ${PREFIX}_part${FILE_IDX}.pdf (pages $START to $END)"
  START=$((END + 1))
  FILE_IDX=$((FILE_IDX + 1))
done
