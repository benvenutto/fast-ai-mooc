FROM nvcr.io/nvidia/pytorch:19.06-py3 AS pytorch

WORKDIR /Docker/workdir

RUN conda create --name fastai python=3.7 && \
	conda install -c fastai fastai && \
	conda uninstall --force jpeg libtiff -y && \
    conda install -c conda-forge libjpeg-turbo && \
    CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd && \
    conda install -c conda-forge jupyter_contrib_nbextensions && \
	conda create --name tf --clone fastai && \
	conda activate tf && \
	conda install -c conda-forge tensorflow

WORKDIR /Docker

EXPOSE 8888

ENTRYPOINT \
	nvidia-smi  -q -i 0 -d POWER && \
	python -m fastai.utils.show_install && \
	jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser 2>&1 
