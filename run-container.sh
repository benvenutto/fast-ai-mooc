#!/bin/bash

	sudo nvidia-smi -pm ENABLED -i 0 && \
    sudo nvidia-smi -pl 217 -i 0

	nvidia-docker run -it --name jupyter --ipc=host --restart unless-stopped -p 8888:8888 -v /home/simonb/Developer:/Docker/Developer "nvidia/pytorch/fastai:19.07-py3"${1}

