FROM debian:testing
MAINTAINER ap13@sanger.ac.uk

RUN apt-get update -qq && apt-get install -y srst2

RUN chmod +x /usr/share/srst2/srst2.py

RUN mkdir -p /mlst_databases/senterica && cd /mlst_databases/senterica && python /usr/share/srst2/getmlst.py --species "Salmonella enterica"

WORKDIR /data


# docker run --rm -it -v /mnt/docker/data/coverage/coverage:/data 8fa40352bad8 bash
# for i in {1..30}; do { time srst2 --output /data/SRST2/srst2_coverage_results_${i} --input_pe CT18_mlstgenes_${i}x_*.fastq.gz --mlst_db /mlst_databases/senterica/Salmonella_enterica.fasta --mlst_definitions /mlst_databases/senterica/senterica.txt --mlst_delimiter '-' > /data/SRST2/srst2_coverage_results_${i} ; }  2> /data/SRST2/srst2_coverage_timing_${i} ; done
#  for i in {1..30}; do  du -c srst2_coverage_results_${i}__* | grep total | awk '{print $1*1000}';  done | paste -
#  ls -rt | grep srst2_coverage_timing | xargs -L 1 tail -n 3 | paste - - - | awk '{print "="$2}' | sed 's/s//gi' | sed 's/m/*60+/gi'
