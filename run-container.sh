#!/bin/bash

	nvidia-docker run --cap-add=SYS_ADMIN -it --name jupyter --ipc=host --restart unless-stopped -p 8888:8888 -v /home/simonb/Developer:/Docker/Developer "nvidia/pytorch/fastai:19.11-py3"${1}

