FROM nvcr.io/nvidia/pytorch:20.03-py3 AS pytorch

WORKDIR /Docker/workdir

ENV NVIDIA_DRIVER_CAPABILITIES="compute,utility"

COPY jupyter_notebook_config.py /root/.jupyter

RUN conda install av -c conda-forge && \
    conda install -c pytorch torchaudio && \
    conda install -c pytorch -c fastai fastai && \
    pip install jupyter_contrib_nbextensions && \
    pip install ipywidgets && \
    jupyter nbextension enable --py widgetsnbextension && \
    CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd && \
    pip install albumentations && \
    pip install workalendar

WORKDIR /Docker

EXPOSE 8888

CMD ["sh","-c", \
	"nvidia-smi -pm ENABLED -i 0 && nvidia-smi -pl 300 -i 0 && jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser"]
