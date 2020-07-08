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

### Preprocess
To preprocess the dataset, you just need to run the following command:

```
docker container run -it --rm --gpus all -v "$(pwd)"/data:/opt/opennmt-py/data opennmt-py \
onmt_preprocess -train_src data/dataset/tr.src -train_tgt data/dataset/tr.tgt \
-valid_src data/dataset/dev.src -valid_tgt data/dataset/dev.tgt \
-save_data data/dataset/preprocess -src_seq_length 70 -tgt_seq_length 70
```

Note: adjust parameters according to your needs.

### Train
You can train a model by running the following command:

```
docker container run -it --rm --gpus all -v "$(pwd)"/data:/opt/opennmt-py/data opennmt-py \
onmt_train python train.py -src_word_vec_size 512 -tgt_word_vec_size 512 \
-rnn_size 512 -data data/dataset/preprocess -save_model data/models/model_name \
-gpu_ranks 0 -batch_size 50 -optim adam -learning_rate 0.0002 -learning_rate_decay 1.0 \
-log_file data/log  -dropout 0 -train_steps 100000 -layers 1 -valid_steps 1000 \
-save_checkpoint_steps 1000 -label_smoothing 0.1 -global_attention mlp
```
Note: adjust parameters according to your needs.

### Translate
To translate a document, you just need to run the following command:

```
docker container run -it --rm --gpus all -v "$(pwd)"/data:/opt/opennmt-py/data opennmt-py \
onmt_translate -model data/models/_model_name_step_step-number.pt \
-src data/dataset/test.src -tgt data/dataset/test.tgt -output data/dataset/test.hyp \
-replace_unk -gpu 0
```

Note: adjust parameters according to your needs.
