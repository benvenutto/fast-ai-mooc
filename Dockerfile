FROM nvcr.io/nvidia/pytorch:19.03-py3 AS pytorch
WORKDIR /workspace/home
RUN conda install -c pytorch -c fastai fastai && \
	conda uninstall --force jpeg libtiff -y && \
    conda install -c conda-forge libjpeg-turbo && \
    CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall --no-binary :all: --compile pillow-simd
EXPOSE 8888
ENTRYPOINT jupyter notebook --ip=0.0.0.0 --port=8888