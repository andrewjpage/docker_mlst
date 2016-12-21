FROM sangerpathogens/ariba

#
#  Authorship
#
MAINTAINER ap13@sanger.ac.uk

#
# Download and build the databases
#
RUN mkdir -p /mlst_databases && \
    cd /mlst_databases && \
    ariba pubmlstget 'Salmonella enterica' salmonella_enterica_db && \
    ariba pubmlstget 'Campylobacter jejuni' campylobacter_jejuni_db && \
    ariba pubmlstget 'Listeria monocytogenes' listeria_monocytogenes_db && \
    ariba pubmlstget 'Escherichia coli#1' escherichia_coli_db

WORKDIR /data
