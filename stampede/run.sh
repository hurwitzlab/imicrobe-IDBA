#!/bin/bash

module load singularity

echo "iMicrobe IDBA-UA begin"
echo "run.sh arguments:"
echo "$@"

mkdir -p idba-ud-output

# must handle 3 cases:
#   single FASTA file
#   single FASTQ file
#   paired FASTQ files
singularity exec imicrobe-idba.img fq2fa --merge --filter $1 $2 idba-ud-output/reads.fa
singularity exec imicrobe-idba.img idba_ud -r idba-ud-output/reads.fa -o idba-ud-output/

echo "iMicrobe IDBA-UA completed"
