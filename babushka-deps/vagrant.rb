dep 'vagrant', :version do
  version.default!('2.2.4')
  file = "vagrant_#{version}_x86_64.deb"
  install_url = 'https://www.virtualbox.org/wiki/Linux_Downloads'
  log "Installing using instructions from: #{install_url}".colorize('blue')
  requires 'deb package'.with(
    url: "https://releases.hashicorp.com/vagrant/#{version}/#{file}",
    temp_file: file,
    exec: 'vagrant',
    version: version
  )
end

