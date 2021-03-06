#! /bin/bash
# Given a directory containing FASTQ files, and an output directory, run using Docker.
# ./run_ariba.sh /mnt/data/coverage /data/ariba compose_ariba salmonella_db

if [ $# -ne 4 ]
then
    echo "Usage: `basename $0` host_base output_directory docker_image database"
    echo "example: ./run_ariba.sh /mnt/data/coverage /data/ariba compose_ariba salmonella_enterica_db"
    echo "Databases available: salmonella_enterica_db campylobacter_jejuni_db listeria_monocytogenes_db escherichia_coli_db"
    exit 1
fi

HOST_BASE=$1
OUTPUT_DIRECTORY=$2
DOCKER_HASH=$3
DATABASE=$4

INPUT_DIRECTORY=/data/
SOFTWARE_NAME=ariba

mkdir -p $OUTPUT_DIRECTORY
mkdir -p $HOST_BASE/$SOFTWARE_NAME
for FORWARD_FILE in $(find ${HOST_BASE} -type f -name "*_1.fastq.gz");
  do
    FORWARD_FILE=${FORWARD_FILE/${HOST_BASE}/${INPUT_DIRECTORY}}
    REVERSE_FILE=${FORWARD_FILE/_1.fastq.gz/_2.fastq.gz}
    BASE_NAME=${FORWARD_FILE/_1.fastq.gz/results}
    BASE_NAME=${BASE_NAME##*/}
    { time docker run --rm -v ${HOST_BASE}:/data ${DOCKER_HASH} ariba run /mlst_databases/${DATABASE}/ref_db ${FORWARD_FILE} ${REVERSE_FILE} ${OUTPUT_DIRECTORY}/output_${BASE_NAME} > ${OUTPUT_DIRECTORY}/results_${BASE_NAME} ; }  2> ${HOST_BASE}/${SOFTWARE_NAME}/timings_${BASE_NAME}
done
