# -*- mode: ruby -*-
# vi: set ft=ruby :

HOSTNAME = 'ansible-st2'

VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.hostname = "#{HOSTNAME}"
  config.vm.network :private_network, ip: '192.168.10.13'
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

  # Use rbconfig to determine if we're on a windows host or not.
  require 'rbconfig'
  is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
  if is_windows
    # Install Ansible if not present
    config.vm.provision :shell,
      :inline => 'if ! command -V ansible >/dev/null 2>&1; then apt-get update && apt-get install -y python-pip && pip install ansible; fi'
    # Run playbook
    config.vm.provision :shell,
      :keep_color => true,
      :inline => "export PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=1; cd /vagrant && ansible-playbook playbooks/st2express.yaml -i 'localhost,' --connection=local"
  else
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/st2express.yaml"
    end
  end
end
