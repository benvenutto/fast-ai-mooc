#!/bin/bash

	docker run --gpus all --cap-add=SYS_ADMIN -it --name udacity --network udacity-net --rm --ipc=host -p 8888:8888 -v /home/simonb/Developer:/Docker/Developer "nvidia/pytorch/fastai:21.10-py3.udacity"
