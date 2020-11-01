

DOCKER ?= docker

all: prod ### dev

prod:
	$(DOCKER) build --pull -t "nvidia/pytorch/fastai:20.09-py3" -f Dockerfile .

dev:
	$(DOCKER) build --pull -t "nvidia/pytorch/fastai:20.09-py3.DEV" -f Dockerfile.dev .

udacity:
	$(DOCKER) build --pull -t "nvidia/pytorch/fastai:20.09-py3.udacity" -f Dockerfile.udacity .