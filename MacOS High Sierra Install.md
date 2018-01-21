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

Next we install additional Anaconda packages, and upgrades.

`
conda install -y bcolz
conda upgrade -y --all
`

Next we want to install Theano as the backend for Keras. There are MacOS installation
instructions [here](http://deeplearning.net/software/theano_versions/dev/install_macos.html).

First we will install dependencies, including clang and the BLAS library.
On MacOS clang comes with XCode, install the latest MKL library build from the
[Intel page](https://software.intel.com/en-us/mkl).

`
xcode-select --install
conda install -y NumPy SciPy mkl-service
`

Now we install Theano. We will use the latest master from github.

`
git clone git://github.com/Theano/Theano.git
cd Theano
pip install -e .
`

Now configure Theano to use the MKL BLAS library, by adding the following lines
to the Theano config file in `~/.theanorc`:

`
[blas]
ldflags = -lmkl_rt
`

Next we install Keras.

`
pip install keras==1.1.2
`

And after installing Keras change the config as described [here](http://wiki.fast.ai/index.php/Local_install_(OSX_only)).

# Enabling eGPU support

The hardware and OS configuration I am testing against is:

* MacBook Pro 13" early 2015, 2.9 Ghz i5, 16 GB
* MacOS High Sierra 10.13.2 (build 17C205)
* Akitio Node eGPU enclosure, TunderBolt 3
* EVGA GeForce GTX 1070 Ti SC GAMING Black Ed. ACX 3.0 8GB GDDR5
* Apple TH3 - TH2 bi-directional adapter
