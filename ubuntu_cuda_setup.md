# Supplimental instructions to setup Nvidia GPU in Ubuntu 16.04 for compute only

### Instruction as of 7/14/2017

### Main CUDA installation guide: http://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html

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
5. run nvidia-smi to verify the driver installed correctly. 
6. After installing TF, run the following script to verfity TF can use the GPU. 
```
import tensorflow as tf
with tf.device('/gpu:0'):
    a = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[2, 3], name='a')
    b = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[3, 2], name='b')
    c = tf.matmul(a, b)

with tf.Session() as sess:
    print (sess.run(c))
```
7. Additional Notes:
    - TF does NOT work with the latest python 3.6. so create a conda env with Python 3.5 for it. 
8. After a while nvidia-smi stopped being able to communicate with the GPU. Had to reinstall CUDA8 twice for the GPU to work properly again. Does this happen only after a dist-upgrade?
9. select nvidia driver from the 'additional drivers' app to make sure using the right openGL driver. 
10. Nvidia driver setup may be causing the login loop after the P710 wake up from s3. Try newer driver installed through apt-get. check which version of the driver for which card. 
11. the 375.25 driver from cuda 8 are too old to support 1080 ti. need to install the 381 with apt-get first (installing 384 run file led to login loop) and then install cuda 8 without the driver and openGL. This lead to modification of xorg so the previous setup of using GPU for compute only no longer works. right now about 400MB memory is used for display even though iGPU is used for display. Changing config to use iGPU as primary also led to login loop. 
