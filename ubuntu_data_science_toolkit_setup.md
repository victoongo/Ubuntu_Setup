
# miniconda 3.6
bash Miniconda3-latest-Linux-x86_64.sh
- create env 3.5
conda create -n py35 python=3.5
source activate py35
conda install pandas scikit-learn statsmodels jupyter seaborn plotly 
pip install ipython-autotime

# h2o
1. Install Java 8 jdk: sudo apt-get install openjdk-8-jdk
2. Download and unzip h2o to use with flow independently
3. conda install -c h2oai h2o=3.14.0.2
    - List of versions: https://anaconda.org/h2oai/h2o/files
4. java -Xmx24g -jar h2o.jar -name V8 (without a unique name, h2o will attempt to join anohter cloud on the LAN.)

# Sparklingwater
export PATH="/home/victor/Applications/sparkling-water-2.2.0/bin:$PATH"
export PYTHONPATH=/home/victor/Applications/sparkling-water-2.2.0/py:/home/victor/Applications/sparkling-water-2.2.0/py/build:$PYTHONPATH

# Deepwater

# XGBoost
git clone --recursive https://github.com/dmlc/xgboost
cd xgboost
mkdir build
cd build
cmake .. -DUSE_CUDA=ON
make -j
Only set the environment variable PYTHONPATH to tell python where to find the library. For example, assume we cloned xgboost on the home directory ~. then we can added the following line in ~/.bashrc. It is recommended for developers who may change the codes. The changes will be immediately reflected once you pulled the code and rebuild the project (no need to call setup again)
export PYTHONPATH=~/xgboost/python-package

# LightGBM

# keras

# tensorflow

# Spark

# jupyter security
http://jupyter-notebook.readthedocs.io/en/latest/public_server.html#securing-a-notebook-server
source activate py35
jupyter notebook --generate-config
jupyter notebook password

# sublime

