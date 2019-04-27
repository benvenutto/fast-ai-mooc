

DOCKER ?= docker

all: prod dev

prod:
	$(DOCKER) build -t "nvidia/pytorch/fastai:19.04-py3" -f Dockerfile .

dev:
	$(DOCKER) build -t "nvidia/pytorch/fastai:19.04-py3.DEV" -f Dockerfile.dev .