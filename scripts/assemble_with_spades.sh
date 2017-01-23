#! /bin/bash
# Given a directory of FASTQ files and an output directory, produce assemblies with spades
# assemble_with_spades.sh /mnt/data/coverage /data /data/fastas


if [ $# -ne 3 ]
then
    echo "Usage: `basename $0` host_base input_directory output_directory"
    exit 1
fi

HOST_BASE=$1
INPUT_DIRECTORY=$2
OUTPUT_DIRECTORY=$3
DOCKER_HASH=compose_spades

mkdir -p $OUTPUT_DIRECTORY
for FORWARD_FILE in $(find ${HOST_BASE} -type f -name "*_1.fastq.gz");
  do
    FORWARD_FILE=${FORWARD_FILE/${HOST_BASE}/${INPUT_DIRECTORY}}
    REVERSE_FILE=${FORWARD_FILE/_1.fastq.gz/_2.fastq.gz}
    BASE_NAME=${FORWARD_FILE/_1.fastq.gz/}
    BASE_NAME=${BASE_NAME##*/}
    
    if [ ! -f ${HOST_BASE}/fastas/${BASE_NAME}/contigs.fasta ]; then
       { time docker run -it --rm -v ${HOST_BASE}:/data ${DOCKER_HASH} spades.py --only-assembler -t 1 -1 ${FORWARD_FILE} -2 ${REVERSE_FILE} -o ${OUTPUT_DIRECTORY}/${BASE_NAME} --phred-offset 33 ; }  2> ${HOST_BASE}/fastas/timings_${BASE_NAME}
    fi
    
done
