#!/bin/bash
source "/vagrant/scripts/variable.sh"

function updateHosts {
    echo "---- Update Host ----"
    sudo apt-get update
    echo "---- Upgrade System ----"
    sudo apt-get upgrade -y
    echo "---- COMPLETE Upgrade System ----"
}
function setupHosts {
    echo "---- Disable firewall ----"
    ufw disable
	
    echo "---- Config hosts file ----"
	# cannot use below commands because it will make wrong hosts file
    # sudo echo "172.16.0.11 node01" | sudo tee -a /etc/hosts
    # sudo echo "172.16.0.12 node02" | sudo tee -a /etc/hosts
    # sudo echo "172.16.0.13 node03" | sudo tee -a /etc/hosts
	
	entry="172.16.0.11 node01"
	echo "${entry}" >> /etc/nhosts
	entry="172.16.0.12 node02"
	echo "${entry}" >> /etc/nhosts
	entry="172.16.0.13 node03"
	echo "${entry}" >> /etc/nhosts

	echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" >> /etc/nhosts
	echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/nhosts

	cp /etc/nhosts /etc/hosts
	rm -f /etc/nhosts	
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    sudo systemctl restart sshd	
    echo "---- COMPLETE Config Hosts file ----"	
}

echo " ---- Starting Upgrade System ----- "
updateHosts

echo "---- Starting to disable firewall and config hosts file -------"
setupHosts

