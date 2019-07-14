FROM nvcr.io/nvidia/pytorch:19.06-py3 AS pytorch

WORKDIR /Docker/workdir

RUN conda update conda-build && \
	conda install -c fastai fastai && \
	conda uninstall --force jpeg libtiff -y && \
    conda install -c conda-forge libjpeg-turbo && \
    CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd && \
    conda install -c conda-forge jupyter_contrib_nbextensions

WORKDIR /Docker

EXPOSE 8888

ENTRYPOINT \
	nvidia-smi  -q -i 0 -d POWER && \
	python -m fastai.utils.show_install && \
	jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser 2>&1 
