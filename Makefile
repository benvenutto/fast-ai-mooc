

DOCKER ?= docker

all:
	$(DOCKER) build -t "nvidia/pytorch/fastai:19.03-py3" -f Dockerfile .