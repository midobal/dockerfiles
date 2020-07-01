# Machine Translation Applications to Historical Documents
This repo contains the dockerfiles and config files to run the [custom NMT-Keras demo server](https://github.com/midobal/nmt-keras/tree/hd_demo/demo-web) used in the [mthd demo](http://casmacat.prhlt.upv.es/mthd/).

## Language Modernization
You can build the docker image by running:
```
docker build -t modernization ./modern
```

Then, you need to copy your models to `modern/models` and the dataset and training codes to `modern/dataset`. After that, the server can be executed by doing:

```
docker container run -d -it --rm -v "$pwd"/modern/models/:/opt/nmt-keras/models -v "$pwd"/modern/config.py:/opt/nmt-keras/config.py \
-v "$pwd"/modern/dataset/:/opt/nmt-keras/dataset \
-v "$pwd"/modern/config_online.py:/opt/nmt-keras/demo-web/config_online.py \
--gpus all -p 6545:6545 modernization
```

Note: adapt path accordingly if your are not launching the container from this repo's directory.

## Spelling Normalization
You can build the docker image by running:
```
docker build -t spelling ./spell
```

Then, you need to copy your models to `spell/models` and the dataset and to `spell/dataset`. After that, the server can be executed by doing:

```
docker container run -it --rm -v "$pwd"/spell/models/:/opt/nmt-keras/models -v "$pwd"/spell/config.py:/opt/nmt-keras/config.py -v "$pwd"/spell/dataset/:/opt/nmt-keras/dataset -v "$pwd"/spell/config_online.py:/opt/nmt-keras/demo-web/config_online.py --gpus all -p 6546:6546 spelling
```

Note: adapt path accordingly if your are not launching the container from this repo's directory.
