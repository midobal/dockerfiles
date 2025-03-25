FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04

##################
## Requirements ##
##################
SHELL ["/bin/bash", "-c"]
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
RUN apt-get update && apt-get install -y git python3-pip python3-tk python3.10-venv && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
RUN export LD_LIBRARY_PATH=/usr/local/cuda/lib64

##################
## Pip packages ##
##################
RUN pip install accelerate==0.25.0 aiofiles==23.2.1 altair==4.2.2 dadaptation==3.1 diffusers[torch]==0.25.0 \
easygui==0.98.3 einops==0.7.0 fairscale==0.4.13 ftfy==6.1.1 gradio==4.43.0 huggingface-hub==0.20.1 \
imagesize==1.4.1 invisible-watermark==0.2.0 lion-pytorch==0.0.6 lycoris_lora==2.2.0.post3 omegaconf==2.3.0 \
onnx==1.16.1 prodigyopt==1.0 protobuf==3.20.3 open-clip-torch==2.20.0 opencv-python==4.7.0.68 \
prodigyopt==1.0 pytorch-lightning==1.9.0 rich>=13.7.1 safetensors==0.4.2 scipy==1.11.4 timm==0.6.12 tk==0.1.0 \
toml==0.10.2 transformers==4.38.0 voluptuous==0.13.1 wandb==0.15.11 scipy==1.11.4 bitsandbytes==0.43.0 \
tensorboard==2.15.2 tensorflow==2.15.0.post1 onnxruntime-gpu==1.17.1 torch==2.1.2+cu118 torchvision==0.16.2+cu118 \
xformers==0.0.23.post1+cu118 --extra-index-url https://download.pytorch.org/whl/cu118

##################
## Installation ##
##################
RUN git clone --recursive https://github.com/bmaltais/kohya_ss.git /opt/kohya_ss
WORKDIR /opt/kohya_ss
RUN chmod +x ./setup.sh && ./setup.sh


##########################
## Default: train model ##
##########################
CMD python3 kohya_gui.py --share --headless --server_port=5000