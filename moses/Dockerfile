FROM ubuntu:18.04

##################
## Requirements ##
##################
RUN apt-get update && apt-get install -y g++ git subversion automake \
libtool zlib1g-dev libicu-dev libboost-all-dev libbz2-dev liblzma-dev \
python-dev graphviz imagemagick make cmake libgoogle-perftools-dev autoconf \
doxygen && rm -rf /var/lib/apt/lists/*

###################
## Install SRILM ##
###################
RUN mkdir /opt/srilm
WORKDIR /opt/srilm
COPY srilm-1.7.3.tar.gz .
RUN tar xzvf srilm-1.7.3.tar.gz && sed -i '1iSRILM = /opt/srilm' Makefile && \
make && make World

###################
## Install Moses ##
###################
RUN git clone https://github.com/moses-smt/mosesdecoder.git /opt/moses
WORKDIR /opt/moses
RUN ./bjam --with-srilm=/opt/srilm/ -j12

###################
## Install mgiza ##
###################
RUN git clone https://github.com/moses-smt/mgiza.git /opt/moses/mgiza
WORKDIR /opt/moses/mgiza/mgizapp
RUN cmake . && make && make install && \
cp /opt/moses/mgiza/experimental/alignment-enabled/MGIZA/scripts/merge_alignment.py bin/

WORKDIR /opt/moses
