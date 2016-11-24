#! /bin/bash
# Given a directory containing spades assemblies, and an output directory, run using Docker.
# run_mlst_check.sh /mnt/docker/data/coverage /data/mlst_check d7ba2f6c9b78

if [ $# -ne 3 ]
then
    echo "Usage: `basename $0` host_base output_directory docker_hash"
    exit 1
fi

HOST_BASE=$1
OUTPUT_DIRECTORY=$2
DOCKER_HASH=$3

INPUT_DIRECTORY=/data
SOFTWARE_NAME=mlst_check

mkdir -p $OUTPUT_DIRECTORY
mkdir -p $HOST_BASE/$SOFTWARE_NAME
for FASTA_FILE in $(find ${HOST_BASE} -type f -name "contigs.fasta");
  do
    FASTA_FILE=${FASTA_FILE/${HOST_BASE}/${INPUT_DIRECTORY}}
    BASE_NAME=${FASTA_FILE/\/contigs.fasta/}
    BASE_NAME={ basename $BASE_NAME }
    BASE_NAME=${BASE_NAME##*/}
    { time docker run --rm -v ${HOST_BASE}:/data ${DOCKER_HASH} get_sequence_type -s 'Salmonella enterica' -o ${OUTPUT_DIRECTORY}/results_${BASE_NAME}  ${FASTA_FILE} > ${HOST_BASE}/${SOFTWARE_NAME}/output_${BASE_NAME} ; }  2> ${HOST_BASE}/${SOFTWARE_NAME}/timings_${BASE_NAME}
done


# grep real timings_CT18_mlstgenes_* | awk -F '_'  '{print $4}' | sed 's/x:real\t0m/\t/' | sed 's/s//'