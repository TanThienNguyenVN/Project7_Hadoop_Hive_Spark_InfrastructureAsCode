## Project 7: Basic Big Data Architecture with Hadoop-Hive-Spark using Infrastructure as Code (IaC)
-----------------------

### Demo here https://youtu.be/j8SnfELG7Sw

### Problem Statement 
- We (Data Analysis Team in Company A) are facing several issues when using existing DWH Architecture to store and extract data for analysis as below:
```
Performance:
  - Huge amount of data
  - A lot of users are using at the same time

Availability:
  - Whenever running ETL, all tables in DWH will be locked
  - Downtime whenever server is failed

Response Time:
  - Only provide batch-processing, not real-time
```

![Existing Architecture](/pictures/existingArchitecture.PNG)

- Therefore, we would like to migrate this existing architecture into a new one to resolve the above problems. 

- We expect to build a new system with high scalability, high availability, and high performance for a vast amount of data.

### Solution Proposal
- We decided to choose Hadoop Ecosystem (HDFS, Hive, and Spark) for POC and Performance Test before bringing it all into production. 

- Installation steps (end-to-end) are expected to be conducted using VagrantFile. However, we will do it step-by-step manually first to ensure each step works well.

- The configs, which cannot be scripted in VagrantFile, will be run in post-provisioning steps
```
Hadoop Cluster 
  - Hadoop multiple nodes cluster is expected to replace traditional storage.

Hive 
  - Hive is expected to replace for existing DWH (metadata).

Spark
  - Spark engine is expected to bring more powerful and faster query processing.

Vagrant
  - Using Vagrantfile to bring three ubuntu VirtualBox up and install Hadoop cluster on top of them.

  - A shared folder between the host PC and VMs will be created. Configuration files used for Hadoop, Hive, and Spark will be shared here.
```

#### Proposal Diagram for Solution.

![Proposal Architecture](/pictures/proposalArchitecture.PNG)

### Prerequisites
#### Hardware Preparation
- Node1: 40G/3G RAM/2Core - NameNode for Hadoop, MasterNode for Spark and Hive
- Node2: 40G/1G RAM/1Core - DataNode for Hadoop and Slaves for Spark
- Node3: 40G/1G RAM/1Core - DataNode for Hadoop and Slaves for Spark

#### Packages MUST BE DOWNLOADED and put into /packages folder. Github doesnot allow to upload big file > 100MB, so, I cannot put them into Github.
- Oracle Java: jdk-8u171-linux-x64.tar.gz (https://download.oracle.com/otn/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz)
- Hadoop: hadoop-3.2.1.tar.gz (https://archive.apache.org/dist/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz)
- Hive: apache-hive-3.1.2-bin.tar.gz (https://dlcdn.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz)
- Spark: spark-3.0.3-bin-hadoop3.2.tgz (https://dlcdn.apache.org/spark/spark-3.0.3/spark-3.0.3-bin-hadoop3.2.tgz)

### Source code tree
```
README.md        : The markdown. Please read this first
Vagrantfile      : File. To build up virtual machines with configuration
/scripts          : Folder. Contain all script to be run in Vagrantfile
/packages         : Folder. Contain package to be installed
/configs          : Folder. Contain configuration files
/code             : Shared folder. to move configuration files from host to VMs
/postprovisioning : Folder. Contain script to run post provisioning
/log              : Folder. Contain gitbashlog and Issue Log
/document         : Folder. Contain Screenshots and Report
/pictures         : Folder. Contain images
/backup           : Folder. Contain backup versions
```

### Step-by-step Implementation
```
Step 0. Vagrant up - Vagrantfile will create 3 VMs on 172.16.0.x/24 network and do the following jobs:
       - Update and upgrade system
       - Define name, RAM, CPU, Shared folder
       - Configure hosts file
       - Install Java and export PATH
       - Install Hadoop, export PATH, configure files, and grant permission to Vagrant user
       - Install Hive, export PATH, configure files, and grant permission to Vagrant user
       - Install Spark, export PATH, configure files, and grant permission to Vagrant user

Important Note: 
       - If you cannot vagrant up successfully, dont be panic. Please check whether you did git pull all folders and downloaded all necessary packages.
       - If you did all above things but still cannot vagrant up successfully. Again, dont be panic. Double check or contact me at C00278719@itcarlow.ie
       - I did testing many many times this git, and I promise you it work.

Step 1. Post Provisioning Checklist (/postprovisioning/Step1-Post-Provisioning-Checklist.sh)
       - IP, ping, hosts, Java, PATH
       - Hadoop Configuration
       - Hive Configuration
       - Spark Configuration

Step 2. Post Provisioning SSH keygen generation, share and start system (/postprovisioning/Step2-Post-Provisioning-SSH-Start.sh)
       - SSH keygen generation in node01 and share to node02 and node03
       - Format HDFS and start HDFS and Yarn
       - Testing YARN job by calculating Pi
       - Create folder HDFS for Hive, Init Hive metastore and start Hive
       - Create folder HDFS for Spark and start Spark
       - Testing Spark by calculating Pi

Step 3. Post provisioning Run Examples (/postprovisioning/Step3-Post-Provisioning-Run-Example.sh)
       - Play with Hive: Create table, drop table - Insert/update/delete - Run SQL query
       - Play with Spark: Run count job

```

### Conclusion and Discussion
- This proposal successfully installed the CORE part, including Hadoop clustered, Yarn, Hive, and Spark, on three Ubuntu Virtualboxes using Vagrantfile.

- There are some configs that cannot be scripted. Therefore, I have to run them manually in [Step2-Post-Provisioning-SSH-Start](/postprovisioning/Step2-Post-Provisioning-SSH-Start.sh)

- Hive and Spark samples are executed in [Step3-Post-Provisioning-Run-Example](/postprovisioning/Step3-Post-Provisioning-Run-Example.sh)

- All Issues were logged in [log](/log) folder.

- The [Report](/document/CA3_Tan%20Thien%20Nguyen_Report.pdf) and [Step by Step Screenshots](/document/Appendix%20A_Step-by-step%20Screenshots_Tan%20Thien%20Nguyen.pdf) are stored in [document](/document) folder for more detail.

### Future Implementation
- Future implementation is about loading raw data into Hive and connecting SparkSQL to Hive using Pyspark to analyze and visualize data on Jupyter notebook.

- There are more configs, and version compatibility checks need to be done to complete the ultimate flow in the future.

### Reference
- https://medium.com/@jootorres_11979/how-to-set-up-a-hadoop-3-2-1-multi-node-cluster-on-ubuntu-18-04-2-nodes-567ca44a3b12
- https://dzone.com/articles/install-a-hadoop-cluster-on-ubuntu-18041
- https://github.com/eellpp/spark-yarn-hadoop-cluster-vagrant
- https://sysadmins.co.za/setup-hive-on-hadoop-yarn-cluster/
- https://sparkbyexamples.com/hadoop/apache-hadoop-installation/
- https://sparkbyexamples.com/hadoop/yarn-setup-and-run-map-reduce-program/
- https://sparkbyexamples.com/spark/spark-setup-on-hadoop-yarn/
- https://spark.apache.org/docs/latest/sql-data-sources-hive-tables.html
- https://www.linode.com/docs/guides/install-configure-run-spark-on-top-of-hadoop-yarn-cluster/
- https://sparkbyexamples.com/apache-hadoop/hadoop-hdfs-dfs-commands-and-starting-hdfs-dfs-services/
- https://spark.apache.org/examples.html
- https://stackoverflow.com/
