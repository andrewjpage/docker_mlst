#! /bin/bash
# Given a directory containing FASTQ files, and an output directory, run using Docker.
# run_stringMLST.sh /mnt/docker/data/coverage /data/stringMLST cfd15249f17a

if [ $# -ne 3 ]
then
    echo "Usage: `basename $0` host_base output_directory docker_hash"
    exit 1
fi

HOST_BASE=$1
OUTPUT_DIRECTORY=$2
DOCKER_HASH=$3

INPUT_DIRECTORY=/data
SOFTWARE_NAME=stringMLST

mkdir -p $OUTPUT_DIRECTORY
mkdir -p $HOST_BASE/$SOFTWARE_NAME
for FORWARD_FILE in $(find ${HOST_BASE} -type f -name "*_1.fastq.gz");
  do
    FORWARD_FILE=${FORWARD_FILE/${HOST_BASE}/${INPUT_DIRECTORY}}
    REVERSE_FILE=${FORWARD_FILE/_1.fastq.gz/_2.fastq.gz}
    BASE_NAME=${FORWARD_FILE/_1.fastq.gz/results}
    BASE_NAME=${BASE_NAME##*/}
    { time docker run --rm -v ${HOST_BASE}:/data ${DOCKER_HASH} stringMLST.py --predict -1 ${FORWARD_FILE} -2 ${REVERSE_FILE} -p -k 35 -P /stringMLST/SE > ${HOST_BASE}/${SOFTWARE_NAME}/output_${BASE_NAME} ; }  2> ${HOST_BASE}/${SOFTWARE_NAME}/timings_${BASE_NAME}
done
