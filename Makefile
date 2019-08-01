

DOCKER ?= docker

all: prod dev

prod:
	$(DOCKER) build --pull -t "nvidia/pytorch/fastai:19.07-py3" -f Dockerfile .

dev:
	$(DOCKER) build --pull -t "nvidia/pytorch/fastai:19.07-py3.DEV" -f Dockerfile.dev .