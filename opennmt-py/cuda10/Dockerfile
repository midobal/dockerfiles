FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

##################
## Requirements ##
##################
SHELL ["/bin/bash", "-c"]
RUN apt-get update \
    && apt-get install -y \
    locales \
    git \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64

################
## OpenNMT-py ##
################
RUN git clone https://github.com/OpenNMT/OpenNMT-py.git /opt/opennmt-py
WORKDIR /opt/opennmt-py
RUN pip3 install --upgrade pip \
    && pip3 install -e . --no-cache-dir \
    && pip3 install -r requirements.opt.txt \
    && pip3 install sacrebleu

##########################
## Default: train model ##
##########################
CMD onmt_train -config config.yaml
