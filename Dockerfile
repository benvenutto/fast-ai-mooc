FROM nvcr.io/nvidia/pytorch:19.07-py3 AS pytorch

WORKDIR /Docker/workdir

RUN pip install fastai && \
    CC="cc -mavx2" pip install -U --force-reinstall pillow-simd && \
    conda install -c conda-forge jupyter_contrib_nbextensions

WORKDIR /Docker

EXPOSE 8888

CMD nvidia-smi -q -i 0 -d POWER 2>&1
CMD python -m fastai.utils.show_install 2>&1
CMD jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser 2>&1