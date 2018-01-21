# Background
The purpose of this guide is to walk you through the software setup required
by the fast.ai Practical Deep Learning For Coders MOOC, installed on a Mac
running MacOS High Sierra. The key elements are:

* Anaconda: a Python environment geared up to machine learning requirements
* Jupyter Notebook: an interactive environment in which to learn, experiment and share ideas

# Installation

We will run the installation scripts in a Terminal window. Open terminal and
enter the commands in the order listed.


Now download the 64-Bit Graphical Installer from the [Anaconda download page](https://www.anaconda.com/download/#macos), and run it. For part 1 of the MOOC you want the Python 2.7 (Anaconda 2) installer.

Next we install additional Anaconda packages, and upgrades:

`
conda install -y bcolz
conda upgrade -y --all
`

Next we want to install Theano as the backend for Keras. There are MacOS installation
instructions [here](http://deeplearning.net/software/theano_versions/dev/install_macos.html).

First we will install dependencies. Install the latest MKL library build from the
[Intel page](https://software.intel.com/en-us/mkl).

On MacOS clang comes with XCode, so install that and the required libraries:

`
xcode-select --install
conda install -y NumPy SciPy mkl-service
`

Now we install Theano.

`
conda install Theano
`

Now configure Theano to use the MKL BLAS library, by adding the following lines
to the Theano config file in `~/.theanorc`:

`
[global]
device = cpu
floatX = float32

[blas]
ldflags = -lmkl_rt
`

Next we install Keras.

`
pip install keras==1.1.2
`

And after installing Keras change the config as described [here](http://wiki.fast.ai/index.php/Local_install_(OSX_only)).

## Benchmark 1

This benchmark reflects performance on my laptop without GPU support.
The hardware and OS configuration I am testing against is:

* MacBook Pro 13" early 2015, 2.9 Ghz i5, 16 GB
* MacOS High Sierra 10.13.2 (build 17C205)

To benchmark I am running the lesson 1 Dogs vs Cats Jupyter notebook, on each running
I select Kernel -> Restart & Clear Output, then select Cell -> Run All.
The average run time across 3 runs is 72 seconds.

# Enabling eGPU support

As an alternative to using a GPU instance on AWS, which is expensive, I decided
to experiment with an external GPU enclosure with an NVIDIA card, accessed over
Thunderbolt, and supporting NVIDIA and CUDA drivers.

The eGPU configuration I am testing against is:

* Akitio Node eGPU enclosure, TunderBolt 3
* EVGA GeForce GTX 1070 Ti SC GAMING Black Ed. ACX 3.0 8GB GDDR5
* Apple TH3 - TH2 bi-directional adapter

First thing is to download the NVIDIA drivers. Download the NVIDIA card driver
from the NVIDIA site, the links are described in
[this thread](https://www.tonymacx86.com/threads/nvidia-releases-alternate-graphics-drivers-for-macos-high-sierra-10-13-2-378-10-10-10-25.239852/).

Next install the latest NVIDIA CUDA toolkit from the
[NVIDIA page](https://developer.nvidia.com/cuda-downloads?target_os=MacOSX&target_arch=x86_64&target_version=1012).

Lastly, install NVIDIA [DNN](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html).
Register on the developer program and follow the donwload links until you see thenoption to download
[cuDNN v7.0.5 Library for OSX](https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/9.1_20171129/cudnn-9.1-osx-x64-v7-ga)
which corresponds to CUDA 9.1. Follow the instructions to copy files into then
CUDA directories, and add the CUDA libraries to the dynamic library path in `~./bash_profile`:

'
export LD_LIBRARY_PATH=/usr/local/cuda/lib
'

Have a look at how to enable eGPU support for NVIDIA cards on this
[page here](https://egpu.io/forums/mac-setup/wip-nvidia-egpu-support-for-high-sierra/).
There is a script to automate the whole process available in
[github here](https://github.com/goalque/automate-eGPU).

Install some extra Theano dependencies for GPU support:

`
conda install Theano pygpu
pip install pycuda scikit-cuda
`

Now configure Theano to use the CUDA toolkit, by adding the following lines
to the Theano config file in `~/.theanorc`:

`
[global]
device = CUDA
floatX = float32
gpuarray.preallocate = 4096

[dnn]
library_path

[blas]
ldflags = -lmkl_rt
`
