FROM debian:testing
MAINTAINER ap13@sanger.ac.uk

RUN apt-get update -qq && apt-get install -y srst2 libxml2-dev libxslt1-dev python-dev gcc make git bowtie2 samtools ncbi-blast+ python-lxml emboss python-yaml python-numpy python-biopython

RUN git clone https://github.com/phe-bioinformatics/MOST.git

ENV PATH /MOST:$PATH
ENV PYTHONPATH /MOST/modules:$PYTHONPATH

WORKDIR /data

# docker run --rm -it -v /mnt/docker/data/coverage/coverage:/data ce8b6ace2c67 bash
# MOST.py -1 /data/CT18_mlstgenes_5x_1.fastq.gz -2 /data/CT18_mlstgenes_5x_2.fastq.gz -o /data/MOST/output1 -st /MOST/MLST_data/salmonella