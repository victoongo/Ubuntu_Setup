# Supplimental instructions to setup Nvidia GPU in Ubuntu 22.04

### Instruction as of 04/06/2024

* Use original ubuntu LTS kernel version. And avoid latest LTS due to lack of cuda support.

1. Go to this link to choose the desired tf version, usually latest or close to the latest that a whl file can be found. try to find one with similar cuda supported by pytorch to avoid any conflicts. currently
```
tensorflow==2.15.0
```
https://www.tensorflow.org/install/source#tested_build_configurations
https://www.tensorflow.org/install/pip
2. Check the currently installed nvidia driver version. If it looks old, do apt update & full-upgrade. If nvidia driver is not installed, install as below. Need to find a driver version that pairs with the desired cuda version.
https://docs.nvidia.com/deploy/cuda-compatibility/index.html#use-the-right-compat-package
```
sudo ubuntu-drivers list --gpgpu
sudo apt install nvidia-driver-535
```
3. Check the cuda version that comes paired with the driver (cuda==12.2 for driver==535). Then install the cuda tool kit version that is the same. Download and install the right version of the cuda took kit with deb(network). (note runfile will allow choice of components in the package. But must be uninstalled with a cuda-uninstall file and nvidia-uninstall file)
```
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
# wget https://developer.download.nvidia.com/compute/cuda/12.2.2/local_installers/cuda-repo-ubuntu2204-12-2-local_12.2.2-535.104.05-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-12-2-local_12.2.2-535.104.05-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-12-2-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda
```
4. Install the required cuDNN (cudnn==8.9)

```
# wget https://developer.download.nvidia.com/compute/cudnn/8.9.0/local_installers/cudnn-local-repo-ubuntu2204-8.9.7.29_1.0-1_amd64.deb
sudo dpkg -i cudnn-local-repo-ubuntu2204-8.9.7.29_1.0-1_amd64.deb
sudo cp /var/cudnn-local-repo-ubuntu2204-8.9.7.29/cudnn-local-08A7D361-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install libcudnn8
sudo apt-get -y install libcudnn8-dev
```
5. Setup PATH in .bashrc or .bash_profile by add the following to the end:

```
export CUDA_HOME="/usr/local/cuda"
export CUDNN_PATH="/usr/include"
export LD_LIBRARY_PATH="$CUDNN_PATH/lib":"/usr/local/cuda/lib64"
export PATH="$PATH":"/usr/local/cuda/bin"

```
6. run nvidia-smi to verify the driver installed correctly.
7. Set up a conda env with the right python version.
https://www.tensorflow.org/install/source#tested_build_configurations
7. install the right tf verion, potentially from a whl file.
```
pip install tf.whl
```
8. After installing TF, run the following script to verfity TF can use the GPU.
```
import tensorflow as tf
with tf.device('/gpu:0'):
    a = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[2, 3], name='a')
    b = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[3, 2], name='b')
    c = tf.matmul(a, b)

with tf.Session() as sess:
    print (sess.run(c))
```
9. use nvtop to monitor GPU usage.

