#!/bin/bash

	docker run --gpus all --cap-add=SYS_ADMIN -it --name udacity --rm --ipc=host -p 8888:8888 -p 127.0.0.1:5432:5432 -v /home/simonb/Developer:/Docker/Developer "nvidia/pytorch/fastai:20.10-py3.udacity"
