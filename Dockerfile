FROM nvcr.io/nvidia/pytorch:19.11-py3 AS pytorch

WORKDIR /Docker/workdir

ENV NVIDIA_DRIVER_CAPABILITIES="compute,utility"

COPY jupyter_notebook_config.py /root/.jupyter

RUN conda install -c conda-forge jupyter_contrib_nbextensions && \
    pip install ipywidgets && \
    jupyter nbextension enable --py widgetsnbextension && \
    conda install -c conda-forge jupyter_contrib_nbextensions && \
    conda install -c conda-forge albumentations && \
    conda install -c conda-forge workalendar && \
    pip uninstall -y pillow && \
    CC="cc -mavx2" pip install -U --force-reinstall pillow-simd

WORKDIR /Docker

EXPOSE 8888

CMD ["sh","-c", \
	"nvidia-smi -pm ENABLED -i 0 && nvidia-smi -pl 300 -i 0 && jupyter notebook --allow-root --ip='0.0.0.0' --port=8888 --no-browser"]
