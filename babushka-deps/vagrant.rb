dep 'vagrant' do
  version='1.7.2'
  file = "vagrant_#{version}_x86_64.deb"
  requires 'deb package'.with(
    url: "https://dl.bintray.com/mitchellh/vagrant/#{file}",
    temp_file: file,
    exec: 'vagrant',
    version: version
  )
end

