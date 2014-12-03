# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

$script = <<SCRIPT
sudo su vagrant -c "/home/vagrant/.start-me-up/bootstrap.sh"
SCRIPT

$desktop_script = <<SCRIPT
apt-get -y install ubuntu-desktop 
SCRIPT

headless = ENV.fetch('HEADLESS', 'true') == 'true'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.hostname = 'start-me-up'
  config.vm.synced_folder '.', '/home/vagrant/.start-me-up'
  config.vm.provider 'virtualbox' do |vb|
    vb.gui = !headless
    vb.memory = headless ? 512 : 1024
    vb.cpus = 1
  end
  config.vm.provision 'shell', inline: $desktop_script unless headless
  config.vm.provision 'shell', inline: $script
end
