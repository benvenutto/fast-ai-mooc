FROM nvcr.io/nvidia/pytorch:20.09-py3 AS pytorch

WORKDIR /Docker/workdir

ENV NVIDIA_DRIVER_CAPABILITIES="compute,utility"

COPY jupyter_notebook_config.py /root/.jupyter

RUN conda install av -c conda-forge && \
    conda install -c fastai -c pytorch -c anaconda fastai gh anaconda && \
    pip install jupyter_contrib_nbextensions && \
    pip install ipywidgets && \
    jupyter nbextension enable --py widgetsnbextension && \
    CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd && \
    pip install albumentations && \
    pip install workalendar

WORKDIR /Docker

EXPOSE 8888

CMD nvidia-smi -pm ENABLED -i 0 2>&1
CMD nvidia-smi -pl 300 -i 0 2>&1
CMD nvidia-smi -q -i 0 -d POWER 2>&1
CMD jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser 2>&1
