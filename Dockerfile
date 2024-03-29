FROM nvcr.io/nvidia/pytorch:21.10-py3 AS pytorch

WORKDIR /Docker/workdir

ENV NVIDIA_DRIVER_CAPABILITIES="compute,utility"

COPY jupyter_notebook_config.py /root/.jupyter

# RUN conda install av -c conda-forge && \
#     conda install --no-deps -c fastai -c anaconda fastai gh anaconda && \
#     pip install jupyter_contrib_nbextensions && \
#     pip install ipywidgets && \
#     jupyter nbextension enable --py widgetsnbextension && \
#     CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd && \
#     pip install albumentations && \
#     pip install workalendar && \
#     pip install tweepy

WORKDIR /Docker

EXPOSE 8888

CMD nvidia-smi -pm ENABLED -i 0 \
    && nvidia-smi -pl 300 -i 0 \
    && nvidia-smi -q -i 0 -d POWER \
    && jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser 2>&1
