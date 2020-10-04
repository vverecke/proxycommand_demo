verbosity = false

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "hostname"
  config.vm.box = "minimal/trusty64"

  config.vm.define "server1" do |server1|
    server1.vm.hostname = "192-168-0-1"
    server1.vm.network "private_network", ip: "192.168.30.11"
  end

  config.vm.define "server2" do |server2|
    server2.vm.hostname = "192-168-0-2"
    server2.vm.network "private_network", ip: "192.168.30.12"
  end

  config.vm.define "server3" do |server3|
    server3.vm.hostname = "192-168-0-3"
    server3.vm.network "private_network", ip: "192.168.30.13"
  end

  config.vm.define "server4" do |server4|
    server4.vm.hostname = "192-168-0-4"
    server4.vm.network "private_network", ip: "192.168.30.14"
  end

  config.vm.define "bastion1" do |bastion1|
    bastion1.vm.hostname = "212-186-105-45"
    bastion1.vm.network "private_network", ip: "212.186.105.45"
      bastion1.vm.provision :ansible do |ansible|
      ansible.playbook = 'ansible/set-prerequisites.yml'
      ansible.verbose = "vvv"
    end
    bastion1.vm.provision "shell", path: "scripts/set-keypairs.sh", args: "-n 192.168.30.11", privileged: false
    bastion1.vm.provision "shell", path: "scripts/set-keypairs.sh", args: "-n 192.168.30.12", privileged: false
  end

  config.vm.define "bastion2" do |bastion2|
    bastion2.vm.hostname = "212-186-105-48"
    bastion2.vm.network "private_network", ip: "212.186.105.48"
      bastion2.vm.provision :ansible do |ansible|
      ansible.playbook = 'ansible/set-prerequisites.yml'
      ansible.verbose = verbosity
    end
    bastion2.vm.provision "shell", path: "scripts/set-keypairs.sh", args: "-n 192.168.30.13", privileged: false
  end

  config.vm.define "bastion3" do |bastion3|
    bastion3.vm.hostname = "212-186-105-49"
    bastion3.vm.network "private_network", ip: "212.186.105.49"
    bastion3.vm.provision :ansible do |ansible|
      ansible.playbook = 'ansible/set-prerequisites.yml'
      ansible.verbose = verbosity
    end
    bastion3.vm.provision "shell", path: "scripts/set-keypairs.sh", args: "-n 192.168.30.14", privileged: false
  end

  config.vm.define 'controller' do |controller|
   controller.vm.network "private_network", ip: "192.168.30.10"
   controller.vm.provision :ansible do |ansible|
     ansible.playbook = 'ansible/set-prerequisites.yml'
     ansible.verbose = verbosity
   end

   controller.vm.provision "file", source: "ansible.cfg", destination: "~/.ansible.cfg"
   addresses = ["192.168.30.11", "192.168.30.12", "192.168.30.13", "192.168.30.14", "212.186.105.45", "212.186.105.48", "212.186.105.49"]
   addresses.each do |address|
     controller.vm.provision "shell", path: "scripts/set-keypairs.sh", args: "-n #{address}", privileged: false
   end
   controller.vm.provision :ansible_local do |ansible|
     ansible.playbook       = "ansible/playbook.yml"
     ansible.verbose        = verbosity
     ansible.install        = true
     ansible.limit          = "servers"
     ansible.inventory_path = "ansible/hosts"
   end
 end
end
