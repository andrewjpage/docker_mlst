#! /bin/bash
# Given a directory containing FASTQ files, and an output directory, run using Docker.
# ./run_srst2.sh /mnt/data/coverage /data/srst2 compose_srst2 Salmonella_enterica

if [ $# -ne 4 ]
then
    echo "Usage: `basename $0` host_base output_directory docker_hash"
    echo "Example: ./run_srst2.sh /mnt/data/coverage /data/srst2 compose_srst2 Salmonella_enterica"
    echo "Databases: Salmonella_enterica Campylobacter_jejuni Listeria_monocytogenes Escherichia_coli"
    exit 1
fi

HOST_BASE=$1
OUTPUT_DIRECTORY=$2
DOCKER_HASH=$3
DATABASE=$4

INPUT_DIRECTORY=/data/
SOFTWARE_NAME=srst2

mkdir -p $OUTPUT_DIRECTORY
mkdir -p $HOST_BASE/$SOFTWARE_NAME
for FORWARD_FILE in $(find ${HOST_BASE} -type f -name "*_1.fastq.gz");
  do
    FORWARD_FILE=${FORWARD_FILE/${HOST_BASE}/${INPUT_DIRECTORY}}
    REVERSE_FILE=${FORWARD_FILE/_1.fastq.gz/_2.fastq.gz}
    BASE_NAME=${FORWARD_FILE/_1.fastq.gz/results}
    BASE_NAME=${BASE_NAME##*/}
    
    COMMAND_TO_RUN="srst2 --output ${OUTPUT_DIRECTORY}/results_${BASE_NAME} --input_pe ${FORWARD_FILE} ${REVERSE_FILE}"
    
    if [[ $DATABASE == "Salmonella_enterica" ]]; then
       COMMAND_TO_RUN="$COMMAND_TO_RUN --mlst_db /mlst_databases/senterica/Salmonella_enterica.fasta --mlst_definitions /mlst_databases/senterica/senterica.txt --mlst_delimiter '-' "
    elif [[ $DATABASE == "Campylobacter_jejuni" ]]; then
       COMMAND_TO_RUN="$COMMAND_TO_RUN --mlst_db /mlst_databases/cjejuni/Campylobacter_jejuni.fasta --mlst_definitions /mlst_databases/cjejuni/campylobacter.txt --mlst_delimiter '_' "
    elif [[ $DATABASE == "Listeria_monocytogenes" ]]; then
       COMMAND_TO_RUN="$COMMAND_TO_RUN --mlst_db /mlst_databases/lmonocytogenes/Listeria_monocytogenes.fasta --mlst_definitions /mlst_databases/lmonocytogenes/lmonocytogenes.txt --mlst_delimiter '_' "
    elif [[ $DATABASE == "Escherichia_coli" ]]; then
       COMMAND_TO_RUN="$COMMAND_TO_RUN --mlst_db /mlst_databases/ecoli/Escherichia_coli#1.fasta --mlst_definitions /mlst_databases/ecoli/ecoli.txt --mlst_delimiter '-' " 
else
        echo "No valid database provided"
    fi  

    { time docker run --rm -v ${HOST_BASE}:/data ${DOCKER_HASH} ${COMMAND_TO_RUN} > ${OUTPUT_DIRECTORY}/output_${BASE_NAME} ; }  2> ${HOST_BASE}/${SOFTWARE_NAME}/timings_${BASE_NAME}
     
done
