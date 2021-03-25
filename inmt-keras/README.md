# Interactive NMT-Keras
This repo contains a dockerfile and instructions to run the `InteractiveNMT` branch of [NMT-Keras](https://github.com/lvapeab/nmt-keras).

## Build
To build the image, you just need to run the following command (provided that you are inside this repo's directory. Otherwise replace `.` with the proper path):

```
docker build -t inmt-keras .
```

## Run
To run an INMT simulation, you need to run bash inside the container:

```
docker container run -it --rm --gpus all \
    -v "$(pwd)"/config.py:/opt/nmt-keras/config.py \
    -v "$(pwd)"/datasets:/opt/nmt-keras/datasets \
    -v "$(pwd)"/trained_models:/opt/nmt-keras/trained_models \
    inmt-keras /bin/bash
```

where `config.py` is `nmt-keras/config.py`, modified according to your needs; `datasets` is the folder in which the datasets are stored, and contains a folder with the training data; and `trained_models` is the folder in the neural models are stored.

Note: adjust paths accordingly.

### Prefix-based INMT
You can run a prefix-based INMT simulation by running the following command:

```
python interactive_nmt_simulation.py \
    -ds datasets/dataset.pkl \
    -src datasets/corpora/source \
    -trg datasets/corpora/reference \
    --models trained_models/model/epoch_n \
    --prefix \
    -d datasets/corpora/hyp &> log
```

where `dataset.pkl` is the dataset generated at the training process; `corpora` is the folder containing the training data; `source` is the file to translate; `reference` is the file containing the references (for simulating the user); `model` is the folder in which the models are stored; and `epoch_n` is the epoch to use.

### Segment-based INMT
You can run a prefix-based INMT simulation by running the following command:

```
python interactive_nmt_simulation.py \
    -ds datasets/dataset.pkl \
    -src datasets/corpora/source \
    -trg datasets/corpora/reference \
    --models trained_models/model/epoch_n \
    -d datasets/corpora/hyp &> log
```

where `dataset.pkl` is the dataset generated at the training process; `corpora` is the folder containing the training data; `source` is the file to translate; `reference` is the file containing the references (for simulating the user); `model` is the folder in which the models are stored; and `epoch_n` is the epoch to use.
