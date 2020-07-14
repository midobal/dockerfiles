# OpenNMT-py
This repo contains a dockerfile and instructions to run [NMT-Keras](https://github.com/lvapeab/nmt-keras).

## Build
To build the image, you just need to run the following command (provided that you are inside this repo's directory. Otherwise replace `.` with the proper path):

```
docker build -t nmt-keras .
```

## Training
You can train a model by running the following command:

```
docker container run -it --rm --gpus all \
    -v "$(pwd)"/config.py:/opt/nmt-keras/config.py \
    -v "$(pwd)"/datasets:/opt/nmt-keras/datasets \
    -v "$(pwd)"/trained_models:/opt/nmt-keras/trained_models \
    nmt-keras
```

where ```config.py``` is ```nmt-keras/config.py```, modified according to your needs; ```datasets``` is the folder in which to store the datasets, and contains and contains a folder with the training data; and ```trained_models``` is the folder in which to store the neural models.

Note: adjust paths accordingly.

## Decoding
To translate a document, you need to run bash inside the container:

```
docker container run -it --rm --gpus all \
    -v "$(pwd)"/config.py:/opt/nmt-keras/config.py \
    -v "$(pwd)"/datasets:/opt/nmt-keras/datasets \
    -v "$(pwd)"/trained_models:/opt/nmt-keras/trained_models \
    nmt-keras /bin/bash
```

and, then, run the regular decoding command:

```
python sample_ensemble.py \
             --models trained_models/tutorial_model/epoch_1 \
                      trained_models/tutorial_model/epoch_2 \
             --dataset datasets/Dataset_tutorial_dataset.pkl \
             --text examples/EuTrans/test.en
```

Note: adjust paths accordingly.
