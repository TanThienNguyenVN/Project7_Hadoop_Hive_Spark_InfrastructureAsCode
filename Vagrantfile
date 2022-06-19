# Vagrant File - will create 3 VMs on 172.16.0.x/24 network, define name, RAM, CPU, shared folder and then configure hosts file, install java, hadoop, hive and spark.

Vagrant.configure("2") do |config|
  (1..3).each do |i|
    config.vm.define "node0#{i}" do |node|
        node.vm.box = "ubuntu/focal64"
        node.vm.network "private_network", ip: "172.16.0.1#{i}"
        node.vm.provider "virtualbox" do |v|
            v.name = "node0#{i}"
            if i == 1
                v.memory = 3072
                v.cpus = 2
            else
                v.memory = 1024
                v.cpus = 1
            end
        end
        node.vm.hostname = "node0#{i}"
        node.vm.synced_folder "code/", "/app/code"		
        node.vm.provision "shell", path: "scripts/setup-hosts.sh"
        node.vm.provision "shell", path: "scripts/setup-java.sh"
        node.vm.provision "shell", path: "scripts/setup-hadoop-package.sh"
        if i == 1
            node.vm.provision "shell", path: "scripts/setup-hive-package.sh"
        end
        node.vm.provision "shell", path: "scripts/setup-spark-package.sh"		
    end
  end
end
