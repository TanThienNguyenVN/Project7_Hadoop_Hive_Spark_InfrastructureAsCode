#!/bin/bash
source "/vagrant/scripts/variable.sh"

function installSpark {
	FILE=/vagrant/packages/$SPARK_ARCHIVE
	tar -xzf $FILE -C /usr/local
	cd /usr/local
	sudo mv spark-3.0.3-bin-hadoop3.2 spark
	sudo cp -f /app/code/spark/spark.sh /etc/profile.d/spark.sh
	echo " ----- COMPLETE install spark ----- "
}

function configFilesSpark {
	sudo cp -f /app/code/spark/spark-defaults.conf /usr/local/spark/conf/spark-defaults.conf
	sudo cp -f /app/code/spark/slaves /usr/local/spark/conf/slaves
	echo " ---- COMPLETE move spark file ----- "
}

function addUserSpark {
    sudo chown vagrant:root -R /usr/local/spark
    sudo chmod g+rwx -R /usr/local/spark
	echo " ------- COMPLETE ADD USER VAGRANT TO SPARK ---------"
}

echo "------ Starting to install Spark ------"
installSpark

echo "----- Starting to move Spark configure file -----"
configFilesSpark

echo "----- Starting to add user Vagrant to Spark ---------- "
addUserSpark