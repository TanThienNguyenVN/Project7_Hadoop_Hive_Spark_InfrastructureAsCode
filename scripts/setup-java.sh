#!/bin/bash
source "/vagrant/scripts/variable.sh"

function installJava {
    echo "---- Install Open JDK 8 ----"
	FILE=/vagrant/packages/$JAVA_ARCHIVE
	sudo tar -xzf $FILE -C /usr/local
	cd /usr/local
	sudo mv jdk1.8.0_171 java
	echo export JAVA_HOME=/usr/local/java >> /etc/profile.d/java.sh
	echo export PATH=\${JAVA_HOME}/bin:\${PATH} >> /etc/profile.d/java.sh
	sudo cp -f /app/code/environment /etc/environment
    echo "---- COMPLETE install Java ----"
}

echo " ----- Starting to install Java ----- "
installJava
