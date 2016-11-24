FROM debian:testing
MAINTAINER ap13@sanger.ac.uk

RUN apt-get update -qq && apt-get install -y srst2 libxml2-dev libxslt1-dev python-dev gcc make git bowtie2 ncbi-blast+ python-lxml emboss python-yaml python-numpy python-biopython wget

RUN wget https://github.com/samtools/samtools/archive/0.1.18.tar.gz && tar xf 0.1.18.tar.gz && cd /samtools-0.1.18 && make

RUN git clone https://github.com/phe-bioinformatics/MOST.git

ENV PATH /MOST:/samtools-0.1.18:$PATH
ENV PYTHONPATH /MOST/modules:$PYTHONPATH

WORKDIR /data

#grep real timings_CT18_mlstgenes_* | awk -F '_'  '{print $4}' |sed 's/xresults:real\t/\t=/' | sed 's/m/*60+/' | sed 's/s//'
# du . --max-depth=1 | sort | sed 's/.\/output_CT18_mlstgenes_//' | sed 's/xresults//'