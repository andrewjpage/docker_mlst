FROM debian:testing
MAINTAINER ap13@sanger.ac.uk

RUN apt-get update -qq && apt-get install -y git wget samtools bedtools bwa gcc autoconf make python-pip unzip 

RUN pip install pyfaidx 

RUN git clone https://github.com/anujg1991/stringMLST.git

RUN cd /stringMLST/datasets && unzip Salmonella_enterica.zip

ENV PATH /stringMLST:$PATH

RUN cd /stringMLST && stringMLST.py --buildDB -c /stringMLST/datasets/Salmonella_enterica/config.txt -k 35 -P SE  

WORKDIR /data

#cd /data/stringMLST && ls -rt | grep timing | xargs -L 1 cat  | paste - - - - | awk '{print $2}' | sed 's/s//gi' | sed 's/0m//gi'
