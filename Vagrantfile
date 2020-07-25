# -*- mode: ruby -*-
# vi: set ft=ruby :

VIRTUAL_MACHINES = {
  :ubuntu16 => {
    :hostname => 'ansible-st2-ubuntu16',
    :box => 'ubuntu/xenial64',
  },
  :ubuntu18 => {
    :hostname => 'ansible-st2-ubuntu18',
    :box => 'ubuntu/bionic64',
  },
  :centos7 => {
    :hostname => 'ansible-st2-centos7',
    :box => 'centos/7',
  },
  :centos8 => {
    :hostname => 'ansible-st2-centos8',
    :box => 'centos/8',
  },
}

Vagrant.require_version ">= 1.9.1"
Vagrant.configure(2) do |config|
  config.vm.network "forwarded_port", guest: 22, host: 2200, auto_correct: true
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.ssh.forward_agent = true

  VIRTUAL_MACHINES.each do |name, cfg|
    config.vm.define name, autostart: (name == :ubuntu18) do |vm_config|
      vm_config.vm.hostname = cfg[:hostname]
      vm_config.vm.box = cfg[:box]

      vm_config.vm.provider :virtualbox do |vb|
        vb.name = "#{cfg[:hostname]}"
        vb.customize ['modifyvm', :id, '--memory', '4096']
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

      vm_config.vm.provision :ansible_local do |ansible|
        ansible.install = true
        ansible.verbose = true
        ansible.playbook = "stackstorm.yml"
      end
    end
  end
end
