
# ----------- Running Examples ---------

# --- This step must ONLY ONLY be implemented after running commands in post-provisioning.sh script

# ------------------------------------------------------------------# 
                           1. Test hive 
# ------------------------------------------------------------------#

# 1 --  create table and insert /update/delete. If you have a powerful machine, you can run in one shot. Otherwise, Please run below commands one by one .
cd /usr/local/hive/bin
vagrant@node01:/usr/local/hive/bin$ hive


CREATE TABLE master_data_science (id int, name string, address string)
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

# -- Insert records into table --
insert into master_data_science(id, name, address) values (4, 'Li', 'China');
insert into master_data_science(id, name, address) values (3, 'ABC', 'Republic of Ireland');
insert into master_data_science(id, name, address) values (3, 'XYZ', 'Hello');
insert into master_data_science(id, name, address) values (5, 'Omar', 'Republic of Ireland');
insert into master_data_science(id, name, address) values (6, 'Raymonds', 'India');
insert into master_data_science(id, name, address) values (7, 'Karina', 'Republic of Ireland');
insert into master_data_science(id, name, address) values (8, 'Nikkil', 'India');
insert into master_data_science(id, name, address) values (9, 'Abilash', 'India');
insert into master_data_science(id, name, address) values (10, 'Taoqi', 'China');
insert into master_data_science(id, name, address) values (11, 'Ilia', 'Russia');
insert into master_data_science(id, name, address) values (12, 'Marcelino', 'India');

# -- view table -- 
select * from master_data_science;

# -- we see that there is some records need to be cleaned. --
delete from master_data_science where id=3;

# -- And want to update some other records --
update master_data_science set address = 'Ireland' where address = 'Republic of Ireland';

# If you got failed after run update/delete query, run quit hive and log in hive again.
# The reason for this error is because my laptop is not powerful to extend heap memory for all transactional queries in one shot.

# 2 -- Create table from a file stored in hdfs. If you have a powerful machine, you can run in one shot. Otherwise, Please run below commands one by one .

CREATE EXTERNAL TABLE IF NOT EXISTS student
(id int,name string, address string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs://node01:9000/user/datafile';

insert into student(id, name, address) values (1, 'Derry', 'Ireland');
insert into student(id, name, address) values (2, 'Luke', 'Ireland');
insert into student(id, name, address) values (3, 'Tan', 'Vietnam');
insert into student(id, name, address) values (4, 'Karina', 'Ireland');

# --> new records will be stored in the table as well as hdfs file 

# 3 -- union
select id, name, address, source from 
(
select s.*, 'hdfs-student' as source from student s 
union all 
select m.*, 'manual-input' as source from master_data_science m
) h;

# 4 -- set to display column name 
hive> set hive.cli.print.header=true;

# ------------------------------------------------------------------# 
                           2. Test Spark
# ------------------------------------------------------------------#
 
# -- create folder and get input file --
hdfs dfs -mkdir -p /user/spark/input
hdfs dfs -chmod g+w /user/spark/input
hdfs dfs -put /app/code/data/wordcount.csv /user/spark/input

# 1-- Start Pyspark -- 
cd $SPARK_HOME/bin
pyspark


# 2-- Run sample --
>>> input_file = sc.textFile("/user/spark/input/wordcount.csv")
>>> map = input_file.flatMap(lambda line: line.split(" ")).map(lambda word: (word, 1))
>>> counts = map.reduceByKey(lambda a, b: a + b)
>>> counts.saveAsTextFile("/user/spark/output/")
>>>

# 3-- command to check
# please remember to quit pyspark or open another git bash before run below commands
hdfs dfs -ls /
hdfs dfs -ls /user
hdfs dfs -ls /user/spark/output
hdfs dfs -cat /user/spark/output/part-00000
hdfs dfs -cat /user/spark/output/part-00001

# -- remove directory
hdfs dfs -rm -R /user/spark/output/
hdfs dfs -rm -R /user/spark/newoutput/

# -- remove file
hdfs dfs -rm /tmp2/file1
