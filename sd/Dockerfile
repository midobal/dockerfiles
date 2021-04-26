FROM ubuntu:20.04

##################
## Requirements ##
##################
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -yq g++ git subversion automake \
libtool zlib1g-dev libicu-dev libboost-all-dev libbz2-dev liblzma-dev \
python-dev graphviz imagemagick make cmake libgoogle-perftools-dev autoconf \
doxygen python3 && rm -rf /var/lib/apt/lists/*

###################
## Install mgiza ##
###################
RUN git clone https://github.com/moses-smt/mgiza.git /mgiza
WORKDIR /mgiza/mgizapp
RUN cmake . && make && make install

###################
## Install SD ##
###################
RUN git clone https://github.com/midobal/sd.git /sd \
&& sed -i 's/bash/bash\n\nexport GIZA=\/mgiza\/mgizapp\/bin/g' /sd/scr/IBM1Alignments.sh \
&& sed -i 's/python/python3/g' /sd/scr/IBM1Alignments.sh

WORKDIR /sd
