dep 'k3s', :version do
  version.default!('0.5.0')
  met? {
    in_path? "k3s >= #{version}" and
    sudo('k3s kubectl get node') =~ /Ready/
  }
  meet {
    log "Installing from https://github.com/rancher/k3s/blob/master/README.md".colorize('blue')
    sudo 'curl -sfL https://get.k3s.io | sh -'
  }
end
