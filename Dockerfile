FROM nvcr.io/nvidia/pytorch:19.03-py3 AS pytorch

WORKDIR /Docker/workdir

RUN conda install -c conda-forge libjpeg-turbo && \
    CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd && \
    git clone https://github.com/pytorch/vision && \
    (cd vision; python setup.py install) && \
    git clone https://github.com/fastai/fastai && \
    (cd fastai; tools/run-after-git-clone; pip install -e ".[dev]") && \
    conda install -c conda-forge jupyter_contrib_nbextensions

WORKDIR /Docker

CMD jupyter notebook password

EXPOSE 8888

ENTRYPOINT \
	sudo nvidia-smi -pm ENABLED -i 0 && \
	sudo nvidia-smi -pl 217 -i 0 && \
	jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser
