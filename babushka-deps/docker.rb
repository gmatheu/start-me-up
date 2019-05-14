dep 'docker' do
  requires 'docker.managed', 'docker-compose.pip'
end

dep 'docker.managed' do
  key = 'https://download.docker.com/linux/ubuntu/gpg'
  url = '[arch=amd64] https://download.docker.com/linux/ubuntu'
  sig = '0EBF CD88'
  release = `lsb_release -cs`.strip
  requires 'keyed apt source'.with(
    uri: url,
    key_uri: key,
    key_sig: sig,
    repo: 'stable'
  )
  installs 'docker-ce', 'docker-ce-cli', 'containerd.io'
  provides 'docker >= 18.09'
end

dep 'docker-compose.pip' do
  provides 'docker-compose >= 1.24.0'
end
