FROM nvcr.io/nvidia/pytorch:19.07-py3 AS pytorch

WORKDIR /Docker/workdir

ENV NVIDIA_DRIVER_CAPABILITIES="compute,utility"

RUN pip install fastai && \
	pip install albumentations && \
    CC="cc -mavx2" pip install -U --force-reinstall pillow-simd && \
    conda install -c conda-forge jupyter_contrib_nbextensions

WORKDIR /Docker

EXPOSE 8888

CMD ["sh","-c", \
	"nvidia-smi -pm ENABLED -i 0 && nvidia-smi -pl 300 -i 0 && jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser"]
