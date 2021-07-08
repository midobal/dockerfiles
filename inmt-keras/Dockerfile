FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

##################
## Requirements ##
##################
RUN apt-get update && apt-get install -y git default-jre wget locales && \
rm -rf /var/lib/apt/lists/*
RUN export LD_LIBRARY_PATH=/usr/local/cuda/lib64

###############
## NMT-Keras ##
###############
RUN git clone --single-branch --branch  interactive_NMT https://github.com/PRHLT/nmt-keras /opt/nmt-keras
WORKDIR /opt/nmt-keras
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh -O /tmp/miniconda.sh && \
bash /tmp/miniconda.sh -b -p /opt/miniconda && export PATH="/opt/miniconda/bin:$PATH" && \
conda config --set always_yes yes --set changeps1 no && pip install --upgrade pip && \
pip install -e . && pip install tensorflow-gpu==1.15
RUN git clone https://github.com/lvapeab/coco-caption.git
ENV PYTHONPATH="/opt/nmt-keras/coco-caption:$PYTHONPATH"
COPY ./inmt.sh /opt/nmt-keras/inmt.sh
RUN chmod +x /opt/nmt-keras/inmt.sh

#####################
## Locale settings ##
#####################
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen
ENV LC_ALL en_US.UTF-8 
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en

##########################
## Default: train model ##
##########################
CMD export PATH="/opt/miniconda/bin:$PATH" && \
export LD_LIBRARY_PATH=/usr/local/cuda/lib64 && python main.py
