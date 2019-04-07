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

EXPOSE 8888

RUN nvidia-smi -pm ENABLED -i 0 && \
    nvidia-smi -pl 217 -i 0 && \

ENTRYPOINT \
	nvidia-smi  -q -i 0 -d POWER && \
	python -m fastai.utils.show_install && \
	jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser 2>&1 
