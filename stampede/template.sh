#!/bin/bash

echo "Started imicrobe-idba $(date)"

echo "FASTQ_1: \"${FASTQ_1}\""
echo "FASTQ_2: \"${FASTQ_2}\""

sh run.sh ${FASTQ_1} ${FASTQ_2}

echo "Ended imicrobe-idba $(date)"
exit 0
