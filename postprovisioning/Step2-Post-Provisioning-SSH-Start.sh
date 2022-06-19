
#-------------node011111111111111-------------
vagrant ssh node01

# -- generate keygen --
ssh-keygen -t rsa

# -- copy keygen to slave. yes and provide password "vagrant" when required --
ssh-copy-id vagrant@node01
ssh-copy-id vagrant@node02
ssh-copy-id vagrant@node03

# -- format hdfs namenode and start dfs -- 
hdfs namenode -format
start-dfs.sh
jps

# if there is no result after jps command, switch to su vagrant user to check. Provide password "vagrant" as below:
# vagrant@node01:~$ su - vagrant
# Password:
# vagrant@node01:~$ jps
# 12184 Jps
# 11769 NameNode
# 12031 SecondaryNameNode

# if there is any issue 
# stop-dfs.sh
# hdfs namenode -format 
# start-dfs.sh 
# jps

# -- start Yarn and test yarn --
start-yarn.sh
jps
yarn node -list

# -- Test HDFS by calculating Pi. You will see the result after this done
yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar pi 16 1000

# -- Now, we can view Hadoop in Web browser
http://172.16.0.11:9870/dfshealth.html#tab-overview
http://172.16.0.11:9870/explorer.html#/
http://172.16.0.11:8088/cluster

# ---- For hive ------

# -- create directory for hive because these directories were in hive default config. Run one by one to make sure all commands are executed successfully
cd $HADOOP_HOME
hdfs dfs -mkdir -p /tmp
hdfs dfs -chmod g+w /tmp
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /user/hive/warehouse
hdfs dfs -mkdir -p /user/datafile
hdfs dfs -chmod g+w /user/datafile

# -- put test file into HDFS to load into Hive table --
hdfs dfs -put /app/code/data/student.csv /user/datafile

# ---- Initial metastore db for hive 
cd /usr/local/hive/bin
schematool -initSchema -dbType derby

# ---- Now you can use hive. After use below command, you can refer to Step3-Post-Provisioning-Run-Examples to play with Hive.
vagrant@node01:/usr/local/hive/bin$ hive


# ---- For SPARK ----- 
# ---- Create Spark log directory
cd $HADOOP_HOME
hdfs dfs -mkdir -p /spark-logs
hdfs dfs -chmod g+w /spark-logs


# --- Start Spark and Spark History Server
cd $SPARK_HOME/sbin
start-all.sh
start-history-server.sh

# -- Now you can view Spark Status on Web browser
http://172.16.0.11:18080/
http://172.16.0.11:8080/

# -- Test spark by calculating Pi. It will a little bit time to run. You will see the result after this done
cd $SPARK_HOME/bin
spark-submit --deploy-mode client --class org.apache.spark.examples.SparkPi $SPARK_HOME/examples/jars/spark-examples_2.12-3.0.3.jar 10






