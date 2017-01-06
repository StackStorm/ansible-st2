# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

VIRTUAL_MACHINES = {
  :u14 => {
    :hostname => 'ubuntu14',
  },
  :u16 => {
    :hostname => 'ubuntu16',
  },
  :centos6 => {
    :hostname => 'centos6',
  },
  :centos7 => {
    :hostname => 'centos7',
  },
}


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # config.vm.hostname = "#{hostname}"
  config.vm.network "forwarded_port", guest: 22, host: 2200, auto_correct: true
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.ssh.forward_agent = true

  VIRTUAL_MACHINES.each do |name, cfg|
    config.vm.define name do |vm_config|
      vm_config.vm.hostname = cfg[:hostname]

      if name == :u14
        vm_config.vm.box  = 'bento/ubuntu-14.04'
      end
      if name == :u16
        vm_config.vm.box  = 'ubuntu/xenial64'
      end
      if name == :centos6
        vm_config.vm.box  = 'bento/centos-6.7'
      end
      if name == :centos7
        vm_config.vm.box  = 'bento/centos-7.2'
      end

      vm_config.vm.provider :virtualbox do |vb|
        vb.name = "#{cfg[:hostname]}"
        vb.customize ['modifyvm', :id, '--memory', '2048']
      end

      if Vagrant.has_plugin?('vagrant-cachier')
        vm_config.cache.scope = :box
      end

      if Vagrant.has_plugin?('vagrant-hostmanager')
        vm_config.hostmanager.enabled = false
        vm_config.hostmanager.manage_host = true
        vm_config.hostmanager.ignore_private_ip = false
        vm_config.hostmanager.include_offline = true
        vm_config.hostmanager.aliases = ["www.#{cfg[:hostname]}"]
        vm_config.vm.provision :hostmanager
      end

      if vm_config.vm.hostname.include? "ubuntu"
        # Install Ansible native packages so the Ansible provisioner will work on systems
        # without Python 2.7 (i.e. Xenial)
        vm_config.vm.provision "shell",
          inline: "sudo apt-add-repository -y ppa:ansible/ansible; sudo apt-get update; sudo apt-get install -y ansible"
      end
      if vm_config.vm.hostname.include? "centos"
        vm_config.vm.provision "shell",
          inline: "sudo yum -y install epel-release; sudo yum -y install ansible git"
      end

      vm_config.vm.provision :ansible do |ansible|
        ansible.playbook = "requirements.yml"
      end
      vm_config.vm.provision :ansible do |ansible|
        ansible.playbook = "stackstorm.yml"
      end
    end
  end
end
