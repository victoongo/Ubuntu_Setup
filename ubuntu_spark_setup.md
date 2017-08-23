
### install Java and anaconda
```
sudo apt-get install openjdk-7-jdk
```

### get Spark binary and UNPACK at the location you want such as '~/Applications/''
```
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.7.tgz
tar zxf spark-2.0.0-bin-hadoop2.7.tgz
```

### on Ubuntu, add to .bashrc (or .profile). on Mac, add to .bash_profile
```
export PATH="/Users/l323423/Applications/spark-2.0.0-bin-hadoop2.7/bin:$PATH"

export SPARK_HOME=/Users/l323423/Applications/spark-2.0.0-bin-hadoop2.7

export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS="notebook"

export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/build:$PYTHONPATH
```

### Run .bash_profile like this to have the env variables above available:
#### note: .bash_profile autoruns upon restart. so you don't need to run this again
```
. ~/.bash_profile
```

### start pyspark (with jupyter notebook as default) like this:
```
pyspark
```

### remote Ubuntu, like this
```
--pylab inline --no-browser --port=7778" pyspark
```
