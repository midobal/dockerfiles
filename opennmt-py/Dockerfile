FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04

##################
## Requirements ##
##################
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y git python3 python3-pip && \
rm -rf /var/lib/apt/lists/*
RUN export LD_LIBRARY_PATH=/usr/local/cuda/lib64

################
## OpenNMT-py ##
################
RUN git clone --branch legacy https://github.com/OpenNMT/OpenNMT-py.git /opt/opennmt-py
WORKDIR /opt/opennmt-py
RUN python3 setup.py install && pip3 install sacrebleu
