# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

$script = <<SCRIPT
sudo su vagrant -c "/home/vagrant/.start-me-up/bootstrap.sh"
SCRIPT

$desktop_script = <<SCRIPT
apt-get -y install lubuntu-desktop ubuntu-desktop
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'trusty-server-cloudimg-amd64-vagrant-disk1'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
  config.vm.hostname = 'start-me-up'
  config.vm.synced_folder '.', '/home/vagrant/.start-me-up'
  config.vm.provider 'virtualbox' do |vb|
    # vb.gui = true
    vb.memory = 512
  end
  # config.vm.provision 'shell', inline: $desktop_script
  config.vm.provision 'shell', inline: $script
end
