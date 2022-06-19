#!/bin/bash
source "/vagrant/scripts/variable.sh"

function installHadoop {
	FILE=/vagrant/packages/$HADOOP_ARCHIVE
	tar -xzf $FILE -C /usr/local
	cd /usr/local
	sudo mv hadoop-3.2.1 hadoop
	sudo cp -f /app/code/hadoop/hadoop.sh /etc/profile.d/hadoop.sh
	echo " ----- COMPLETE install hadoop ----- "
}

function configFiles {
	sudo cp -f /app/code/hadoop/core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml
	sudo cp -f /app/code/hadoop/hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml
	sudo cp -f /app/code/hadoop/mapred-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml
	sudo cp -f /app/code/hadoop/yarn-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml
	sudo cp -f /app/code/hadoop/workers /usr/local/hadoop/etc/hadoop/workers
	echo " ---- COMPLETE move file ----- "
}

function addUserHadoop {
    sudo chown vagrant:root -R /usr/local/hadoop
    sudo chmod g+rwx -R /usr/local/hadoop
    sudo adduser vagrant sudo
	echo " ------- COMPLETE ADD USER VAGRANT TO SUDO ---------"
}

echo "------ Starting to install hadoop ------"
installHadoop

echo "----- Starting to move hadoop configure file -----"
configFiles

echo "----- Starting to add user Vagrant to Sudo ---------- "
addUserHadoop