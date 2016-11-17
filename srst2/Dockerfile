FROM debian:testing
MAINTAINER ap13@sanger.ac.uk

RUN apt-get update -qq && apt-get install -y srst2

RUN chmod +x /usr/share/srst2/srst2.py

RUN mkdir -p /mlst_databases/senterica && cd /mlst_databases/senterica && python /usr/share/srst2/getmlst.py --species "Salmonella enterica"

WORKDIR /data

# srst2 --output test --input_pe *.fastq.gz --mlst_db /mlst_databases/senterica/Salmonella_enterica.fasta --mlst_definitions /mlst_databases/senterica/senterica.txt --mlst_delimiter '-'
