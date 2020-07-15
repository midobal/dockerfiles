FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

##################
## Requirements ##
##################
#SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y git default-jre wget && \
rm -rf /var/lib/apt/lists/*
RUN export LD_LIBRARY_PATH=/usr/local/cuda/lib64

###############
## NMT-Keras ##
###############
RUN git clone https://github.com/lvapeab/nmt-keras /opt/nmt-keras
WORKDIR /opt/nmt-keras
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
bash /tmp/miniconda.sh -b -p /opt/miniconda && export PATH="/opt/miniconda/bin:$PATH" && \
conda config --set always_yes yes --set changeps1 no && conda update -q conda && conda init && \
pip install -e .

##########################
## Default: train model ##
##########################
CMD export PATH="/opt/miniconda/bin:$PATH" && \
export LD_LIBRARY_PATH=/usr/local/cuda/lib64 && python main.py