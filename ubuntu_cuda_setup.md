# Supplimental instructions to setup Nvidia GPU in Ubuntu 16.04 for compute only

### Instruction as of 7/14/2017

### Main CUDA installation guild: http://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html

1. Perform Pre-installation Actions for CUDA 8.0
    - Roll back kernel version to original LTS if needed. Cuda may not play nice with the newer HWE stack. 
    - GCC version roll back is not necessary if you don't develop in CUDA but rather just use GPU for deep learning. 
2. Choose and download Runfile installation package so that you can choose NOT to install OpenGL and use IGPU for display. Here are the steps to install CUDA:
    - Ctrl + Alt + F1 to enter tty1. Log in. 
    - run sudo service lightdm stop to disable GUI. 
    - run sudo bash nvidia-***.sh to install CUDA. Accept everything but NOT OpenGL (to use IGPU for display to save a little vram in the nvidia GPU and prevent diaplay freeze during deep learning) and optionally CUDA examples and symlink. 
    - run sudo bash nvidia-***.sh for any updates if available. 
    - run sudo service lightdm start to get back to GUI
3. Install cuDNN
    - Download cuDNN 5.1 for CUDA 8 and it extract to a place of your choice. 
4. Setup PATH in .bashrc or .bash_profile by add the following to the end:

```
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=/home/victor/Applications/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```
5. Additional Notes:
    - TF does NOT work with the latest python 3.6. so create a conda env with Python 3.5 for it. 