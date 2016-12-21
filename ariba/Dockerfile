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
RUN git clone -b pubmlst https://github.com/martinghunt/ariba.git && cd ariba && python3 setup.py install

RUN cd / && ariba pubmlstget 'Salmonella enterica' salmonella_enterica_db
RUN cd / && ariba pubmlstget 'Campylobacter jejuni' campylobacter_jejuni_db
RUN cd / && ariba pubmlstget 'Listeria monocytogenes' listeria_monocytogenes_db
RUN cd / && ariba pubmlstget 'Escherichia coli#1' escherichia_coli_db


WORKDIR /data

# ls -rt | grep timing | xargs -L 1 cat  | paste - - - - | awk '{print $2}' | sed 's/s//gi' | sed 's/0m//gi'
#for x in {1..30}; do echo "_______________ $x ______________________";  cut -f2,5-8,9,10,13 ariba_coverage_output_${x}/report.tsv ; done