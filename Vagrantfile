# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$script = <<SCRIPT
sudo su vagrant -c "sudo /home/vagrant/.stu/bootstrap.sh"
SCRIPT

$desktop_script = <<SCRIPT
apt-get -y install lubuntu-desktop ubuntu-desktop
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "trusty-server-cloudimg-amd64-vagrant-disk1"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.synced_folder ".", "/home/vagrant/.stu"
  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  # config.vm.provision 'shell', inline: $desktop_script
  config.vm.provision 'shell', inline: $script
end
