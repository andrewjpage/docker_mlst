FROM debian:testing
MAINTAINER ap13@sanger.ac.uk

RUN apt-get update -qq && apt-get install -y git wget samtools bedtools bwa gcc autoconf make python-pip unzip 
RUN pip install pyfaidx 

# Get the latest version of the code
RUN git clone https://github.com/anujg1991/stringMLST.git
ENV PATH /stringMLST:$PATH

# Download and prepare all databases
RUN cd /stringMLST && stringMLST.py --getMLST -P mlst_dbs --species all

WORKDIR /data

./run_stringMLST.sh /mnt/data/coverage /data/stringMLST compose_stringmlst salmonella-enterica