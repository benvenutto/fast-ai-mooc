FROM nvcr.io/nvidia/pytorch:19.07-py3 AS pytorch

WORKDIR /Docker/workdir

ENV NVIDIA_DRIVER_CAPABILITIES="compute,utility"

RUN pip install fastai && \
    CC="cc -mavx2" pip install -U --force-reinstall pillow-simd && \
    conda install -c conda-forge jupyter_contrib_nbextensions

WORKDIR /Docker

EXPOSE 8888

CMD nvidia-smi -pm ENABLED -i 0
CMD nvidia-smi -pl 217 -i 0
CMD nvidia-smi -q -i 0 -d POWER
CMD python -m fastai.utils.show_install
CMD jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser
