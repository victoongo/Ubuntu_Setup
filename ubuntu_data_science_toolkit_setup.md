# Create folder for Apps
```
mkdir ~/Applications
```

# miniconda 3.6
```
wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
# create env 3.5
conda create -n py35 python=3.5
source activate py35
conda install pandas scikit-learn statsmodels jupyter seaborn plotly 
pip install ipython-autotime keras catboost lightgbm
```

# h2o
```
sudo apt-get install openjdk-8-jdk
# Download and unzip h2o to use with flow independently
wget http://h2o-release.s3.amazonaws.com/h2o/rel-wheeler/2/h2o-3.16.0.2.zip
pip install http://h2o-release.s3.amazonaws.com/h2o/rel-wheeler/2/Python/h2o-3.16.0.2-py2.py3-none-any.whl
java -Xmx24g -jar h2o.jar -name V8 # without a unique name, h2o will attempt to join anohter cloud on the LAN.
```

# Sparklingwater
```
wget http://h2o-release.s3.amazonaws.com/sparkling-water/rel-2.2/3/sparkling-water-2.2.3.zip
```
```
export PATH="/home/user/Applications/sparkling-water-2.2.3/bin:$PATH"
export PYTHONPATH=/home/user/Applications/sparkling-water-2.2.3/py:/home/user/Applications/sparkling-water-2.2.3/py/build:$PYTHONPATH
```
# Deepwater

# XGBoost
```
git clone --recursive https://github.com/dmlc/xgboost
cd xgboost
mkdir build
cd build
cmake .. -DUSE_CUDA=ON
make -j
```
Only set the environment variable PYTHONPATH to tell python where to find the library. For example, assume we cloned xgboost on the home directory ~. then we can added the following line in ~/.bashrc. It is recommended for developers who may change the codes. The changes will be immediately reflected once you pulled the code and rebuild the project (no need to call setup again)
```
export PYTHONPATH=~/xgboost/python-package
```

# LightGBM w/ GPU support 
## install cmake
```
wget https://cmake.org/files/v3.10/cmake-3.10.0-Linux-x86_64.sh
bash cmake-3.10.0-Linux-x86_64.sh
```
## install boost compute
```
sudo apt-get install libboost-dev libboost-system-dev libboost-filesystem-dev
```
## build lightgbm with gpu support
```
git clone --recursive https://github.com/Microsoft/LightGBM ; cd LightGBM
mkdir build ; cd build
<!-- cmake -DUSE_GPU=1 .. -->
# if you have installed the NVIDIA OpenGL, please use following command instead
sudo cmake -DUSE_GPU=1 -DOpenCL_LIBRARY=/usr/local/cuda/lib64/libOpenCL.so -OpenCL_INCLUDE_DIR=/usr/local/cuda/include/ ..
make -j4
```

# tensorflow

# Spark

# jupyter security
http://jupyter-notebook.readthedocs.io/en/latest/public_server.html#securing-a-notebook-server
```
source activate py35
jupyter notebook --generate-config
jupyter notebook password
```

# sublime

# pycharm