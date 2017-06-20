#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 00:30:00
#SBATCH -p development
#SBATCH -J test-SOAPdenovo2

OUT_DIR="$SCRATCH/imicrobe-IDBA/test"

if [[ -d $OUT_DIR ]]; then
  rm -rf $OUT_DIR
fi

mkdir -p $OUT_DIR

./run.sh "$SCRATCH/imicrobe-IDBA/test-data/test.fa" $OUT_DIR
