# -*- mode: ruby -*-
# vi: set ft=ruby :

HOSTNAME = 'ansible-st2'

VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/xenial64'
  config.vm.hostname = "#{HOSTNAME}"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provider :virtualbox do |vb|
    vb.name = "#{HOSTNAME}"
    vb.customize ['modifyvm', :id, '--memory', '2048']
  end

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end

  if Vagrant.has_plugin?('vagrant-hostmanager')
    config.hostmanager.enabled = false
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    config.hostmanager.aliases = ["www.#{HOSTNAME}"]
    config.vm.provision :hostmanager
  end

  # Install Ansible native packages so the Ansible provisioner will work on systems
  # without Python 2.7 (i.e. Xenial)
  config.vm.provision "shell",
    inline: "sudo apt-add-repository -y ppa:ansible/ansible; sudo apt-get update; sudo apt-get install -y ansible"

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "requirements.yml"
  end
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "stackstorm.yml"
  end
end
