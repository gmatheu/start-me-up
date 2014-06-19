dep 'firefox.managed' do
  requires 'ppa'.with('ppa:ubuntu-mozilla-security/ppa')
  installs 'firefox'
  provides 'firefox'
end
