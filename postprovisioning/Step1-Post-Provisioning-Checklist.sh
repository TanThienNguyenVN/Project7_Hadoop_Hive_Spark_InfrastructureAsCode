
# ----------- Post Provisioning Check List ---------

# ---- NODE0111111111111 ---- 
# ---- Below steps can be implemented after node01 up ----

#1. Run below commands to quick check environment --
ping node01 -c 3
ping node02 -c 3
ping node03 -c 3
more /etc/hosts
java -version
python3 --version

echo $JAVA_HOME
echo $HADOOP_HOME
echo $HIVE_HOME
echo $SPARK_HOME
echo $PATH 
more /etc/environment 

#2. Check Hadoop config files
cd $HADOOP_HOME/etc/hadoop
more core-site.xml
more yarn-site.xml
more hdfs-site.xml
more mapred-site.xml

#3. Check Hive config files and guava-27.0-jre.jar lib
cd $HIVE_HOME
more bin/hive-config.sh
more conf/hive-site.xml 
cd /usr/local/hive/lib/
ls | grep guava


#4. check Spark config
cd $SPARK_HOME/conf
more spark-defaults.conf

# ---- NODE02 and NODE03 ---- 
# ---- Do the same all steps but step 3. Hive is only installed on Node01 ----
