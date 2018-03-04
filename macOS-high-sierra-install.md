# Background
The purpose of this guide is to walk you through the software setup required
for the fast.ai Practical Deep Learning For Coders MOOC, installed on a Mac
running macOS High Sierra.

The fast.ai trainers encourage the use of a standardised cloud computing platform
based on a number of providers offering GPU compute capability. This allows the team
to focus on teaching the subject matter (not resolving people's infrastructure
issues), and gives people access to the required GPU compute and associate libraries,
as well as a standard OS: Ubuntu.

A number of people have created localised implementations of this setup, for specific
platforms. The one I want to focus on is a MacBook Pro laptop running macOS 10.13.3
High Sierra. I want this setup to be usable when I am on the move (e.g.: train) and
disconnected, and hence can only use local compute. Whilst this first configuration
is very limited, it should allow development and computation using trivial data sets.

So in summary, the two use cases I want to cover are:

1. Local processing on the move, using a Python installation optimised for Intel processor
2. Desktop bound processing, using a Thunberbolt connected eGPU supporting CUDA compute

The key elements in both installations are:

* Anaconda: a Python environment oriented towards machine learning requirements
* Jupyter Notebook: an interactive environment in which to learn, experiment and share ideas
* Pytorch: a Python deep learning framework support fast computation of tensors and dynamic neural nets

# CPU Installation

The first step is to install Anaconda. Go to the Anaconda [download page](https://www.anaconda.com/download/#macos)
and chose the MacOs graphical installer.

Now open a terminal window and switch to a command line interface.
Our first installation is CPU based only. The fast.ai install places the CPU only
configuration in an environment called *fastai-cpu*, so we create that and switch to it.

~~~~
conda create --name fastai-cpu
source activate fastai-cpu
~~~~

Next install the Intel processor optimisations for Python 3 into the current environment,
as explained [here](https://software.intel.com/en-us/articles/using-intel-distribution-for-python-with-anaconda).

~~~~
conda install --channel intel intelpython3_core python=3
~~~~

Having installed the Intel optimisations we clone this environment, to create the
foundation for the environment that includes GPU support, as any CPU optimisations
will also be useful there. The fast.ai environment with GPU support is called *fastai*.

~~~~
conda create --name fastai --clone fastai-cpu
~~~~

Now we refer to the fast.ai installation instructions. First clone the project,
then change directory into it.

~~~~
git clone https://github.com/fastai/fastai.git
cd fastai
~~~~

Now update this environment with the CPU only library configuration:

~~~~
conda env update -f environment-cpu.yml
~~~~

# CPU Validation

Before going further lets validate that out local CPU configuration is working.
Start a new terminal window, cd into the `fastai` directory, and run Jupiter notebook.

~~~~
cd fastai
jupyter notebook
~~~~

Select the lesson one `lesson1.ipynb` notebook, in the `courses/dl1` directory.
Now follow the instructions to create the data files; run the commands below to
download and unzip the data directories, this will take a few minutes.

~~~~
cd courses/dl1
mkdir data
cd data
curl -O http://files.fast.ai/data/dogscats.zip
unzip dogscats.zip
~~~~

Now if you run through the notebook,


# GPU installation

Pytorch on macOS currently doesn't have a standard build that includes CUDA support.
I won't go into the details of why (!) Apple currently has such poor support for
NVIDIA GPUs and hence CUDA, however it is possible to get NVIDIA cards working on a Mac.

First switch environments.

~~~~
source activate fastai
~~~~

The next step is then to create a Pytorch build [from source](https://github.com/pytorch/pytorch#from-source).

~~~~
export CMAKE_PREFIX_PATH=[anaconda root directory]
conda install numpy pyyaml setuptools cmake cffi typing
~~~~

The directory `[anaconda root directory]` above is the directory anaconda is installed in.
Unless you chose an alternative directory in the installer, by default it will be under
your home directory, specifically in `~/anaconda3`.

Now cd into an appropriate directory, and pull down the Pytorch sources from [github](https://github.com/pytorch)
and cd into the Pytorch directory.

~~~~
git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
~~~~

And next run the Pytorch install. At this point you want your GPU discoverable,
so that the build optimises for it! So plug in and power up your eGPU enclosure.

Please make sure that CUDA has been installed as per the instructions on the NVIDIA
[CUDA installation page](http://docs.nvidia.com/cuda/cuda-installation-guide-mac-os-x/index.html).

Also, check that `/usr/local/cuda` exists, as the make checks for it. If required
run the command `sudo ln -n -s /Developer/NVIDIA/CUDA-9.1/ /usr/local/cuda`
(assumes your CUDA installation version is 9.1).

Finally, check that you have the XCode command line tools installed, you can download
the package from here: [Command Line Tools macOS 10.13 for Xcode 9.2](https://download.developer.apple.com/Developer_Tools/Command_Line_Tools_macOS_10.13_for_Xcode_9.2/Command_Line_Tools_macOS_10.13_for_Xcode_9.2.dmg).

~~~~
MACOSX_DEPLOYMENT_TARGET=10.9 CC=clang CXX=clang++ python setup.py install
~~~~
