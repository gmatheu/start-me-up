dep 'docker' do
  requires 'docker.managed', 'docker-compose.pip'
end

dep 'docker.managed' do
  key = 'https://get.docker.io/gpg'
  url = 'https://get.docker.io/ubuntu'
  sig = '36A1D7869245C8950F966E92D8576A8BA88D21E9'
  requires 'keyed apt source'.with(
    uri: url,
    key_uri: key,
    key_sig: sig,
    release: 'docker',
    repo: 'main'
  )
  installs 'lxc-docker'
  provides 'docker >= 1.0'
end

dep 'docker-compose.pip'
