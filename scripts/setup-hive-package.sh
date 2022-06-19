#!/bin/bash
source "/vagrant/scripts/variable.sh"

function installHive {
	FILE=/vagrant/packages/$HIVE_ARCHIVE
	tar -xzf $FILE -C /usr/local
	cd /usr/local
	sudo mv apache-hive-3.1.2-bin hive
	sudo cp -f /app/code/hive/hive.sh /etc/profile.d/hive.sh
	sudo cp -f /app/code/hive/hive-config.sh /usr/local/hive/bin/hive-config.sh
	sudo cp -f /app/code/hive/hive-site.xml /usr/local/hive/conf/hive-site.xml
	sudo cp -f /app/code/hive/hive-schema-3.1.0.derby.sql /usr/local/hive/scripts/metastore/upgrade/derby/hive-schema-3.1.0.derby.sql
	sudo rm /usr/local/hive/lib/guava-19.0.jar
	sudo cp /usr/local/hadoop/share/hadoop/hdfs/lib/guava-27.0-jre.jar /usr/local/hive/lib/
	echo " ---- COMPLETE install Hive  -----"
}

function addUserHive {
    sudo chown vagrant:root -R /usr/local/hive
    sudo chmod g+rwx -R /usr/local/hive
	echo " ------- COMPLETE ADD USER VAGRANT TO SUDO ---------"
}

echo "------ Starting to install Hive ------"
installHive

echo "----- Starting to add user Vagrant to Sudo ---------- "
addUserHive
