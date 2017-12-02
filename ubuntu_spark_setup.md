
### install Java and anaconda
```
sudo apt-get install openjdk-8-jdk
```

### get Spark binary and UNPACK at the location you want such as '~/Applications/''
```
wget wget http://mirror.jax.hugeserver.com/apache/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz
tar zxf spark-2.2.0-bin-hadoop2.7.tgz
```

### add to .bashrc (or .profile). on Mac, add to .bash_profile
```
export PATH="/home/user/Applications/spark-2.2.0-bin-hadoop2.7/bin:$PATH"

export SPARK_HOME=/home/user/Applications/spark-2.2.0-bin-hadoop2.7

export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS="notebook"

export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/build:$PYTHONPATH
```

### Run .bashrc to have the env variables above available:
#### note: .bashrc autoruns upon restart. so you don't need to run this again
```
. ~/.bashrc
```

### activate the conda env as needed
```
source activate myenv
```

### start pyspark (with jupyter notebook as default):
```
pyspark
```

#### remote Ubuntu
```
--pylab inline --no-browser --port=7778" pyspark
```

### get spark config
#### As SparkContext is already available in your Notebook:
```
sc._conf.get('spark.driver.memory')
```

#### You can set as well, but you have to shutdown the existing SparkContext first:
```
conf = SparkConf().setAppName("App")
conf = (conf.setMaster('local[*]')
        .set('spark.executor.memory', '4G')
        .set('spark.driver.memory', '6G')
        .set('spark.driver.maxResultSize', '6G'))
sc = SparkContext(conf=conf)
```

#### change defaults for all analysis, edit spark-defaults.conf 
```
spark.executor.memory		4G
spark.driver.memory		6G
spark.driver.maxResultSize	6G
```

### check spark cluster status (when there is a spark kernel running)
http://localhost:4040
