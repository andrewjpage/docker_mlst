#! /bin/bash
# Given a directory containing FASTQ files, and an output directory, run using Docker.
# run_srst2.sh /mnt/docker/data/coverage /data/srst2 8fa40352bad8

if [ $# -ne 3 ]
then
    echo "Usage: `basename $0` host_base output_directory docker_hash"
    exit 1
fi

HOST_BASE=$1
OUTPUT_DIRECTORY=$2
DOCKER_HASH=$3

INPUT_DIRECTORY=/data
SOFTWARE_NAME=srst2

mkdir -p $OUTPUT_DIRECTORY
for FORWARD_FILE in $(find ${HOST_BASE} -type f -name "*_1.fastq.gz");
  do
    FORWARD_FILE=${FORWARD_FILE/${HOST_BASE}/${INPUT_DIRECTORY}}
    REVERSE_FILE=${FORWARD_FILE/_1.fastq.gz/_2.fastq.gz}
    BASE_NAME=${FORWARD_FILE/_1.fastq.gz/results}
    BASE_NAME=${BASE_NAME##*/}
    { time docker run --rm -v ${HOST_BASE}:/data ${DOCKER_HASH} srst2 --output ${OUTPUT_DIRECTORY}/results_${BASE_NAME} --input_pe ${FORWARD_FILE} ${REVERSE_FILE} --mlst_db /mlst_databases/senterica/Salmonella_enterica.fasta --mlst_definitions /mlst_databases/senterica/senterica.txt --mlst_delimiter '-' > ${OUTPUT_DIRECTORY}/output_${BASE_NAME} ; }  2> ${HOST_BASE}/${SOFTWARE_NAME}/timings_${BASE_NAME}
done
