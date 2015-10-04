dep 'vagrant' do
  version=VAGRANT_VERSION
  file = "vagrant_#{version}_x86_64.deb"
  requires 'deb package'.with(
    url: "https://dl.bintray.com/mitchellh/vagrant/#{file}",
    temp_file: file,
    exec: 'vagrant',
    version: version
  )
end

