# Moses
This repo contains a dockerfile and instructions to run [Moses](https://github.com/moses-smt/mosesdecoder).

## Requirements
Before building the image, you need to download [SRILM 1.7.3](http://www.speech.sri.com/projects/srilm/download.html) into the same directory as the dockerfile.

## Build
To build the image, you just need to run the following command (provided that you are inside this repo's directory. Otherwise replace `.` with the proper path):

```
docker build -t moses .
```

## Run
For simplicity, we are going to assume that we have a folder `data` in which to store the models and that it is located in `$(pwd)`. This folder contains the following structure:

* dataset/
  * tr.src.
  * tr.tgt.
  * dev.src.
  * dev.tgt.
  * test.src.
  * test.tgt.
* alignment/
* mert/

where *src* is the source language and *tgt* is the target language.

Note: remember that the dataset must have been tokenized using [tokenize.perl](https://raw.githubusercontent.com/moses-smt/mosesdecoder/master/scripts/tokenizer/tokenizer.perl).

### Language model
You can build the language model by running the following command:

```
docker container run -it --rm -v /data/repos/dockerfiles/moses/data/:/data moses \
/opt/srilm/lm/bin/i686-m64/ngram-count -order 5 -unk -interpolate -kndiscount \
-text /data/dataset/tr.tgt -lm /data/model.lm
```

Note: adjust parameters according to your needs.

### Alignment model
To train the alignment model, you can run the following command:

```
docker container run -it --rm -v /data/repos/dockerfiles/moses/data/:/data moses \
/opt/moses/scripts/training/train-model.perl -mgiza -mgiza-cpus 10 --first-step 1 \
-root-dir /data/alignment -corpus /data/dataset/tr -f src -e tgt \
-alignment grow-diag-final-and -reordering msd-bidirectional-fe -lm 0:5:/data/model.lm \
-external-bin-dir /opt/moses/mgiza/mgizapp/bin/
```
Note: adjust parameters according to your needs.

### MERT
You can adjust the weights of the alignment model by means of MERT:

```
docker container run -it --rm -v /data/repos/dockerfiles/moses/data/:/data moses \
/opt/moses/scripts/training/mert-moses.pl /data/dataset/dev.src \
/data/dataset/dev.tgt /opt/moses/bin/moses /data/alignment/model/moses.ini \
-threads=10 --maximum-iterations=10 --working-dir /data/mert --mertdir \
/opt/moses/bin/ --decoder-flags "-threads 10"
```

Note: adjust parameters according to your needs.

### Translation
You can translate a model by running the following command:

```
docker container run -i --rm -v /data/repos/dockerfiles/moses/data/:/data moses \
/opt/moses/bin/moses -threads 10 -f /data/mert/moses.ini < data/dataset/test.src \
> data/test.hyp
```
Note: adjust file paths and parameters according to your needs.

To reduce RAM consumption, you can filter the alignment model prior to doing the translation:

```
docker container run -it --rm -v /data/repos/dockerfiles/moses/data/:/data moses \
/opt/moses/scripts/training/filter-model-given-input.pl /data/filtered_model \
/data/mert/moses.ini /data/dataset/test.src
```

Then, to translate the document, you just need to replace `/data/mert/moses.ini` by `/data/filtered_model/moses.ini` in the command stated before.
