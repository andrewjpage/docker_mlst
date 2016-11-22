#! /bin/bash
# Given a directory of FASTQ files and an output directory, produce assemblies with spades
# run_most.sh /mnt/docker/data/coverage/fastqs /mnt/docker/data/coverage/fastas

if [ $# -ne 2 ]
then
    echo "Usage: `basename $0` input_directory output_directory"
    exit 1
fi

INPUT_DIRECTORY=$1
OUTPUT_DIRECTORY=$2

for FORWARD_FILE in $(find ${INPUT_DIRECTORY} -type f -name "*_1.fastq.gz");
  do
    REVERSE_FILE=${FORWARD_FILE/_1.fastq.gz/_2.fastq.gz}
    BASE_NAME=${FORWARD_FILE/_1.fastq.gz/}
    BASE_NAME=${BASE_NAME##*/}
    
    spades.py -t 1 -1 ${FORWARD_FILE} -2 ${REVERSE_FILE} -o ${OUTPUT_DIRECTORY}/${BASE_NAME}
done
