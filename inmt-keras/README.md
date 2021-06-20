# Interactive NMT-Keras
This repo contains a dockerfile and instructions to run the `InteractiveNMT` branch of [NMT-Keras](https://github.com/lvapeab/nmt-keras).

## Build
To build the image, you just need to run the following command (inside this repo's directory):

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
    inmt-keras ./inmt.sh -d datasets/dataset.pkl -s datasets/corpus/src_file \
    -r datasets/corpus/ref_file -m trained_models/model/epoch_n -h datasets/hyps \
    -l datasets/log {-p}
```

where `config.py` is `nmt-keras/config.py`, modified according to your needs; `datasets` is the folder in which the datasets are stored, and contains a folder (`corpus`) with the training data; `trained_models` is the folder in the neural models are stored; `dataset.pkl` is the dataset generated at the training process; `src_file` is the file to translate; `ref_file` are the desired translations (for simulating the user); `model` is the folder in which the models are stored; `epoch_n` is the epoch to use; `hyps` is the file in which to store the translation hypothesis; `log` is the file in which to store the session log; and `-p` activates the *prefix-based* approach (default: *segment-based*).

Note: adjust paths accordingly.

**Remember that you can switch between the prefix-based and segment-based protocols by activating or deactivating the `-p` flag**.
