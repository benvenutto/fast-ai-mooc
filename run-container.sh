#!/bin/bash

	nvidia-docker run -d --ipc=host --rm -p 8888:8888 -v /home/simonb/Developer:/Docker/Developer jupyter >/tmp/jupyter.log
