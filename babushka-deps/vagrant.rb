dep 'vagrant' do
  requires 'deb package'.with(
    url: 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb',
    temp_file: 'vagrant_1.7.2_x86_64.deb',
    exec: 'vagrant'
  )
end

