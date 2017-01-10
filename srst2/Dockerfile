FROM debian:testing
MAINTAINER ap13@sanger.ac.uk

RUN apt-get update -qq && apt-get install -y bowtie2 cd-hit python python-biopython python-scipy samtools python-rpy2 python-pip git

RUN pip install git+https://github.com/katholt/srst2

RUN mkdir -p /mlst_databases/senterica && cd /mlst_databases/senterica && getmlst.py --species "Salmonella enterica"

RUN mkdir -p /mlst_databases/cjejuni && cd /mlst_databases/cjejuni && getmlst.py --species "Campylobacter jejuni"

RUN mkdir -p /mlst_databases/lmonocytogenes && cd /mlst_databases/lmonocytogenes && getmlst.py --species "Listeria monocytogenes"

RUN mkdir -p /mlst_databases/ecoli && cd /mlst_databases/ecoli && getmlst.py --species "Escherichia coli#1"


WORKDIR /data

#  for i in {1..30}; do  du -c srst2_coverage_results_${i}__* | grep total | awk '{print $1*1000}';  done | paste -
#  ls -rt | grep srst2_coverage_timing | xargs -L 1 tail -n 3 | paste - - - | awk '{print "="$2}' | sed 's/s//gi' | sed 's/m/*60+/gi'
