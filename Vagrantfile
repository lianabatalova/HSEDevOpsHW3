Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.56.4"
  config.vm.network "private_network", ip: "192.168.56.5"
  config.vm.hostname = "example2.local"

  # Manage host
  if Vagrant.has_plugin?('vagrant-hostmanager')
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
  else
    puts '[WARNING] Host manager plugin is not installed! Please run `vagrant plugin install vagrant-hostmanager`'
  end
 
  # Files for puppet
  config.vm.synced_folder "./puppet-files", "/etc/puppet/files"

  # Provision using puppet
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "default.pp"
    puppet.options = ['--fileserverconfig=/vagrant/fileserver.conf']
  end

  config.vm.post_up_message = "Machine ready, browse to either 192.168.56.4 or 192.168.56.5 in your browser to view pages."
end
