#!/bin/bash

	nvidia-docker run -it --ipc=host --rm -p 8888:8888 -v /home/simonb/Developer:/Docker/Developer jupyter
