# OpenNMT-py
This repo contains a dockerfile and instructions to run [OpenNMT-py](https://github.com/OpenNMT/OpenNMT-py).

## Build
To build the image, you just need to run the following command (provided that you are inside this repo's directory. Otherwise replace `.` with the proper path):

```
docker build -t opennmt-py .
```

## Run
For simplicity, we are going to assume that we have a folder `data` in which to store both the dataset and the models and that it is located in `$(pwd)`. This folder contains the following structure:

* dataset/
  * tr.src.
  * tr.tgt.
  * dev.src.
  * dev.tgt.
  * test.src.
  * test.tgt.
* models/

where *src* is the source language and *tgt* is the target language.

### Config
`config.yaml` contains an example configuration for training a Transformer model.

### Train
You can train a model by running the following command:

```
docker container run -it --rm --gpus all -v "$(pwd)"/data:/opt/opennmt-py/data \
-v "$(pwd)"/config.yaml:/opt/opennmt-py/config.yaml opennmt-py
```

### Translate
To translate a document, you just need to run the following command:

```
docker container run -it --rm --gpus all -v "$(pwd)"/data:/opt/opennmt-py/data \
-v "$(pwd)"/config.yaml:/opt/opennmt-py/config.yaml opennmt-py onmt_translate \
-model data/model/model_step_$n.pt -src data/dataset/test.src -output data/test.hyp \
-gpu 0 -verbose
```

where `model_step_$n.pt` is the desired model to use.
