# This docker container allows you to run Torsten Seemanns MLST software
# docker build .
# docker run --rm -it -v /home/ubuntu/docker_mlst/data:/data ed6dcb29bba5 mlst AL513382.fasta

FROM debian:testing
MAINTAINER ap13@sanger.ac.uk

RUN apt-get update -qq && apt-get install -y libmoo-perl liblist-moreutils-perl git ncbi-blast+ cpanminus gcc autoconf make libxml2-dev zlib1g zlib1g-dev libmodule-install-perl && cpanm -f File::Temp File::Spec Data::Dumper

RUN git clone https://github.com/tseemann/mlst.git

ENV PATH /mlst/bin:$PATH

WORKDIR /data
