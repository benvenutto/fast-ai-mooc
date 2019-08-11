#!/bin/bash

	nvidia-docker run -it --name jupyter --ipc=host --restart unless-stopped -p 8888:8888 -v /home/simonb/Developer:/Docker/Developer "nvidia/pytorch/fastai:19.07-py3"${1}

