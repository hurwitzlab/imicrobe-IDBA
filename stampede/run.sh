#!/bin/bash

module load singularity

INPUT_FILE=$1
OUTPUT_DIR=$2

echo "starting directory : `pwd`"
echo "`ls -l`"
echo "input file       : ${INPUT_FILE}"
echo "output directory : ${OUTPUT_DIR}"

export LAUNCHER_DIR="$HOME/src/launcher"
export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_WORKDIR=${OUTPUT_DIR}
export LAUNCHER_RMI=SLURM

export LAUNCHER_JOB_FILE=`pwd`/launcher_jobfile_${SLURM_JOB_ID}
echo ${LAUNCHER_JOB_FILE}
singularity exec imicrobe-IDBA.img idba-ud \
   -r ${INPUT_FILE} \
   -o ${OUTPUT_DIR}

sleep 10
export LAUNCHER_PPN=2

$LAUNCHER_DIR/paramrun
echo "Ended launcher"
