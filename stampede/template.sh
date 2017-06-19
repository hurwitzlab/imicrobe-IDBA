#!/bin/bash

echo "Started $(date)"

sh run.sh ${INPUT_FILE} `pwd`

echo "Ended $(date)"
exit 0
