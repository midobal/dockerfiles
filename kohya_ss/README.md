# Kohya_ss
This repo contains a dockerfile and instructions to run [Kohya_ss](https://github.com/bmaltais/kohya_ss).

## Build
To build the image, you just need to run the following command (provided that you are inside this repo's directory. Otherwise, replace `.` with the proper path):

```
docker build -t kohya_ss .
```

## Run
For simplicity, we are going to assume that we have a folder `data` in which to store the dataset, the configuration file and the output and that it is located in `$(pwd)`. This folder contains the following structure:

* dataset/
  * image01.png
  * image01.txt
  * ...
  * imageN.png
  * imageN.txt
* `lora.conf`
* output/

where `lora.conf` is the file available at this same repository.

### Run
You can run `kohya_ss` by doing:

```
docker container run -it --rm --gpus all -p 5000:5000 -v ${PWD}/data:/data kohya_ss
```

As a result, both a local address and a gradio URL will be printed. Follow the last one to access to `Kohya_ss` graphical interface.