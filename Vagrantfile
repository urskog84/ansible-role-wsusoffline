# Provisioning configuration for Ansible.


Vagrant.configure("2") do |config|
  config.vm.box = "StefanScherer/windows_2016"
  
  config.vm.define "win-1" do |subconfig1|
    subconfig1.vm.host_name = "win-1"
    subconfig1.vm.network :private_network, ip: "192.168.33.8"
    subconfig1.vm.network :private_network, ip: "10.64.0.8"
    subconfig1.vm.provider "virtualbox" do |vb|
      vb.name = "wsus"
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
  end
end



  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose        = true
    ansible.limit          = "all"
    ansible.inventory_path = "./inventory"
  end
end