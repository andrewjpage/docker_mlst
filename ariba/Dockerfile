FROM debian:testing

#
#  Authorship
#
MAINTAINER ap13@sanger.ac.uk

#
# Install the dependancies
#
RUN apt-get update -qq && apt-get install -y git bowtie2 cd-hit fastaq libc6 libfml0 libgcc1 libminimap0 libstdc++6 mummer python3 python3-setuptools python3-dev python3-pysam python3-pymummer python3-dendropy gcc g++ zlib1g-dev

#
# Get the latest code from github and install
#
RUN git clone -b pubmlst https://github.com/sanger-pathogens/ariba.git && cd ariba && python3 setup.py install

RUN cd / && ariba pubmlstget 'Salmonella enterica' salmonella_db

WORKDIR /data

# docker run --rm -it -v /mnt/docker/data/coverage/coverage:/data 5ae1c974206c bash
# for i in {1..30}; do { time ariba run /salmonella_db/ref_db /data/CT18_mlstgenes_${i}x_1.fastq.gz /data/CT18_mlstgenes_${i}x_2.fastq.gz /data/ariba/ariba_coverage_output_${i} > /data/ariba/ariba_coverage_results_${i} ; }  2> /data/ariba/ariba_coverage_timing_${i} ; done
# ls -rt | grep timing | xargs -L 1 cat  | paste - - - - | awk '{print $2}' | sed 's/s//gi' | sed 's/0m//gi'
#for x in {1..30}; do echo "_______________ $x ______________________";  cut -f2,5-8,9,10,13 ariba_coverage_output_${x}/report.tsv ; done