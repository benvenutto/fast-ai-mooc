#!/bin/bash

	docker run --gpus all --cap-add=SYS_ADMIN -it --name udacity --ipc=host -p 8888:8888 -v /home/simonb/Developer:/Docker/Developer "nvidia/pytorch/fastai:20.09-py3.udacity"
