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

Next install the Intel processor optimisations for Python 3,
as explained [here](https://software.intel.com/en-us/articles/using-intel-distribution-for-python-with-anaconda).

~~~~
conda install --channel intel intelpython3_core python=3
~~~~

Having installed the Intel optimisations we clone this environment, to create the
environment that includes GPU support, as any CPU optimisations will also be useful there.
The fast.ai environment with GPU support is called *fastai*.

~~~~
conda create --name fastai --clone fastai-cpu
~~~~

Now we refer to the fast.ai installation instructions. First clone the project,
then change directory into it.

~~~~
git clone https://github.com/fastai/fastai.git
cd fastai
~~~~

Now refresh the environment with the CPU only library configuration:

~~~~
~~~~
