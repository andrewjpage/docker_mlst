############################################################
# Dockerfile to build CGE Pipeline
# # Define app's environment with a Dockerfile so it can be reproduced anywhere:
# https://bitbucket.org/genomicepidemiology/cge-tools-docker/raw/efacc9cadd8ea6a264d2d450b004434ba6ba1883/Dockerfile
############################################################

# Set base image to Python Anaconda
FROM continuumio/anaconda

# File Author / Maintainer
MAINTAINER Jose Luis Bellod Cisneros

# Update the repository sources list
RUN apt-get install debian-archive-keyring
RUN apt-key update

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils\
    aufs-tools \
    automake \
    blast2 \
    btrfs-tools \
    build-essential \
    ca-certificates \
    curl \
    debian-archive-keyring \
    dpkg-sig \
    emacs \
    git \
    iptables \
    libapparmor-dev \
    libcap-dev \
    libmysqlclient-dev \
    libsqlite3-dev \
    lxc \
    mercurial \
    openssh-server \
    parallel \
    perl \
    pigz \
    r-base \
    reprepro

# Install services from Github (testing repositories)
# TODO Install deployment versions

RUN mkdir /root/.ssh/
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
RUN ssh-keyscan cpanmin.us >> /root/.ssh/known_hosts
RUN echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config

RUN chmod 777 -R /tmp && chmod o+t -R /tmp

RUN mkdir /usr/src/cgepipeline
ADD . /usr/src/cgepipeline
WORKDIR /usr/src/cgepipeline

# INSTALLING SPADES-3.9.0
RUN wget \
    http://spades.bioinf.spbau.ru/release3.9.0/SPAdes-3.9.0-Linux.tar.gz
RUN tar -xzf SPAdes-3.9.0-Linux.tar.gz
ENV PATH $PATH:/usr/src/cgepipeline/SPAdes-3.9.0-Linux/bin

# CGE Tools
#################################################
# Install perl modules
RUN curl -L https://cpanmin.us -k | perl - App::cpanminus
RUN cpanm Try::Tiny::Retry
RUN cpanm CJFIELDS/BioPerl-1.6.924.tar.gz --force
RUN cpanm Data::Dumper
RUN cpanm Getopt::Long
RUN cpanm File::Temp

# Install python modules, pipeline framework and packaged services (Eg. KmerFinder)
WORKDIR /usr/src/cgepipeline
ENV INSTALLING_MODE DEV
RUN python setup.py install

# Download services
RUN git clone "https://bitbucket.org/genomicepidemiology/assembler.git" services/assembler
RUN git clone "https://bitbucket.org/genomicepidemiology/mlst.git" services/mlst
RUN git clone "https://bitbucket.org/genomicepidemiology/plasmidfinder.git" services/plasmidfinder
RUN git clone "https://bitbucket.org/genomicepidemiology/pmlst.git" services/pmlst
RUN git clone "https://bitbucket.org/genomicepidemiology/resfinder.git" services/resfinder
RUN git clone "https://bitbucket.org/genomicepidemiology/virulencefinder.git" services/virulencefinder
# Allow scripts to be executed
RUN find services -type f -iname "*.pl" -print -exec chmod 665 {} \;

# Add service scripts to path
ENV PATH $PATH:/usr/src/cgepipeline/services/assembler/scripts
ENV PATH $PATH:/usr/src/cgepipeline/services/resfinder
ENV PATH $PATH:/usr/src/cgepipeline/services/mlst
ENV PATH $PATH:/usr/src/cgepipeline/services/pmlst
ENV PATH $PATH:/usr/src/cgepipeline/services/virulencefinder
ENV PATH $PATH:/usr/src/cgepipeline/services/plasmidfinder

# Set convinience aliases
RUN echo "alias edit='emacs'" >> /.bashrc
RUN echo "alias ls='ls -h --color=tty'" >> /.bashrc
RUN echo "alias ll='ls -lrt'" >> /.bashrc
RUN echo "alias l='less'" >> /.bashrc
RUN echo "alias du='du -hP --max-depth=1'" >> /.bashrc
RUN echo "alias cwd='readlink -f .'" >> /.bashrc

# Set default working directory
WORKDIR /usr/src/cgepipeline/test