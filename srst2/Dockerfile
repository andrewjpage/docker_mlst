FROM debian:testing
MAINTAINER ap13@sanger.ac.uk

RUN apt-get update -qq && apt-get install -y srst2

RUN chmod +x /usr/share/srst2/srst2.py

RUN mkdir -p /mlst_databases/senterica && cd /mlst_databases/senterica && python /usr/share/srst2/getmlst.py --species "Salmonella enterica"

RUN mkdir -p /mlst_databases/cjejuni && cd /mlst_databases/cjejuni && python /usr/share/srst2/getmlst.py --species "Campylobacter jejuni"

RUN mkdir -p /mlst_databases/lmonocytogenes && cd /mlst_databases/lmonocytogenes && python /usr/share/srst2/getmlst.py --species "Listeria monocytogenes"

RUN mkdir -p /mlst_databases/ecoli && cd /mlst_databases/ecoli && python /usr/share/srst2/getmlst.py --species "Escherichia coli#1"


WORKDIR /data

#  for i in {1..30}; do  du -c srst2_coverage_results_${i}__* | grep total | awk '{print $1*1000}';  done | paste -
#  ls -rt | grep srst2_coverage_timing | xargs -L 1 tail -n 3 | paste - - - | awk '{print "="$2}' | sed 's/s//gi' | sed 's/m/*60+/gi'
