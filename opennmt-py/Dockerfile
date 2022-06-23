FROM nvidia/cuda:11.5.0-cudnn8-runtime-ubuntu20.04

##################
## Requirements ##
##################
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y git python3-pip && \
rm -rf /var/lib/apt/lists/*
RUN export LD_LIBRARY_PATH=/usr/local/cuda/lib64

################
## OpenNMT-py ##
################
RUN git clone https://github.com/OpenNMT/OpenNMT-py.git /opt/opennmt-py
WORKDIR /opt/opennmt-py
RUN pip install -e . --no-cache-dir && pip install -r requirements.opt.txt && \
pip install sacrebleu

##########################
## Default: train model ##
##########################
CMD onmt_train -config config.yaml
