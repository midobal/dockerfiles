# Statistical Dictionary

This repo contains a dockerfile and instructions to translate a text using an [statistical dictionary](https://github.com/midobal/sd).

## Build
To build the image, you just need to run the following command (provided that you are inside this repo's directory. Otherwise replace `.` with the proper path):

```
docker build -t sd .
```

## Usage

### Alignments
Prior to using the dictionary, you need to train the alignment model. You can do so running the following command:

```
docker container run -it --rm \
    -v "$(pwd)"/source_file:/sd/source_file \
    -v "$(pwd)"/target_file:/sd/target_file \
    -v "$(pwd)"/dest_dir:/sd/dest_dir \
    sd scr/IBM1Alignments.sh source_file target_file dest_dir
```

where `source_file` is the source from the parallel training data; `target_file` is the target from the parallel training data; and `dest_dir` is the directory in which to save the alignments.

### Text translation
Finally, you can translate a document by doing:

```
docker container run -it --rm \
    -v "$(pwd)"/text_file:/sd/text_file \
    -v "$(pwd)"/dest_dir/alignments:/sd/alignments \
    sd python scr/SD.py -t text_file -a alignments > hyp
```

where `text_file` is the text to translate; `alignments` is the file created at the alignments step (`dest_dir/alignmetns`); and `hyp` is the resulting translation.
