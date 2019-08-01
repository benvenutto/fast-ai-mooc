#!/bin/bash

	sudo nvidia-smi -pm ENABLED -i 0 && \
    sudo nvidia-smi -pl 217 -i 0

	nvidia-docker run --rm -it --name jupyter --ipc=host -p 8888:8888 -v /home/simonb/Developer:/Docker/Developer "nvidia/pytorch/fastai:19.07-py3"${1}

