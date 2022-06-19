
# ----------- Issue Log ------------
# --- Basic Issue --- 

- IP address
- node name 
- sudo apt get update 
- wrong PATH 

# --- Issue 1 
wrong hosts file --> fixed by change the way to write the hosts file 

#--- Issue 2 
cannot export PATH and JAVA_HOME --> fixed by change the way to export PATH, must write into a file ( >> /etc/profile.d/java.sh)

#--- Issue 3 
CRLF (wrong) instead of LF (right)  --> fixed by change CRLF to LF 

#--- Issue 4
Install Open java (wrong) instead of Oracle JDK (right)  --> fixed by install Oracle JDK 8u171

#--- Issue 5
Permission denied (publickey) due to not edit sshd_config  --> fixed by add PasswordAuthentication = yes in sshd_config file

#--- Issue 6
Cannot script adduser and ssh keygen due to need to provide password and yes --> pending 

#--- Issue 7 
Cannot see a lot of information when run hdfs dfs -ls /
why dont need to edit ./bashrc

#--- Issue 8 
Cannot start Hive 
Exception in thread "main" java.lang.NoSuchMethodError: com.google.common.base.Preconditions.checkArgument(ZLjava/lang/String;Ljava/lang/Object;)V
--> fixed by change guava lib 
sudo rm /usr/local/hive/lib/guava-19.0.jar
sudo cp /usr/local/hadoop/share/hadoop/hdfs/lib/guava-27.0-jre.jar /usr/local/hive/lib/

#--- Issue 9
Exception in thread "main" java.lang.RuntimeException: java.net.ConnectException: Call From node01/172.16.0.11 to node01:9000 failed on connection exception: java.net.ConnectException: Connection refused; For more details see:  http://wiki.apache.org/hadoop/ConnectionRefused

--> Hadoop not yet started 
Need to generate keygen and assign permission to /usr/local/hadoop

#--- Issue 10
Thu Dec 16 18:38:31 UTC 2021 Thread[d66d2193-9959-4e17-96c8-45ef410b2568 main,5,main] java.io.FileNotFoundException: derby.log (Permission denied)
ERROR XBM0H: Directory /usr/local/hive/bin/metastore_db cannot be created.

---> there is no permission 
sudo chown vagrant:root -R /usr/local/hive
sudo chmod g+rwx -R /usr/local/hive

#--- Issue 11

vagrant@node01:/usr/local/hive/bin$ schematool -initSchema -dbType derby
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hive/lib/log4j-slf4j-impl-2.10.0.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop/share/hadoop/common/lib/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]
Metastore connection URL:        jdbc:derby:;databaseName=metastore_db;create=true
Metastore Connection Driver :    org.apache.derby.jdbc.EmbeddedDriver
Metastore connection User:       APP
Starting metastore schema initialization to 3.1.0
Initialization script hive-schema-3.1.0.derby.sql


Error: FUNCTION 'NUCLEUS_ASCII' already exists. (state=X0Y68,code=30000)
org.apache.hadoop.hive.metastore.HiveMetaException: Schema initialization FAILED! Metastore state would be inconsistent !!
Underlying cause: java.io.IOException : Schema script failed, errorcode 2
Use --verbose for detailed stacktrace.
*** schemaTool failed ***
 --> Fixed by edit hive-schema-3.1.0.derby.sql file



# Issue 12 : Cannot update or delete record in hive, only create table 
--> fixed need to update mapred-site.xml and yarn-site.xml to increase memory


# Issue 13: 
Error during job, obtaining debugging information...
FAILED: Execution Error, return code 2 from org.apache.hadoop.hive.ql.exec.mr.MapRedTask
MapReduce Jobs Launched:
Stage-Stage-1:  HDFS Read: 33893 HDFS Write: 20014 FAIL

--> check hive.log
java.lang.Exception: java.lang.OutOfMemoryError: Java heap space
	at org.apache.hadoop.mapred.LocalJobRunner$Job.runTasks(LocalJobRunner.java:492) ~[hadoop-mapreduce-client-common-3.2.1.jar:?]
	at org.apache.hadoop.mapred.LocalJobRunner$Job.run(LocalJobRunner.java:552) ~[hadoop-mapreduce-client-common-3.2.1.jar:?]
Caused by: java.lang.OutOfMemoryError: Java heap space

--> fixed by increase memory in mapred-site.xml from 256 to 512
