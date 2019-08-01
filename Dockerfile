FROM nvcr.io/nvidia/pytorch:19.07-py3 AS pytorch

WORKDIR /Docker/workdir

RUN conda install -c fastai fastai && \
    conda uninstall --force jpeg libtiff -y && \
    CC="cc -mavx2" pip install -U --force-reinstall pillow-simd && \
    conda install -c conda-forge jupyter_contrib_nbextensions

WORKDIR /Docker

EXPOSE 8888

ENTRYPOINT \
	nvidia-smi  -q -i 0 -d POWER && \
	python -m fastai.utils.show_install && \
	jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser 2>&1 
