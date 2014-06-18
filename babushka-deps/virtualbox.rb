dep 'virtualbox' do
  requires 'virtualbox.managed'
end

dep 'virtualbox.managed' do
  key = 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc'
  url = 'http://download.virtualbox.org/virtualbox/debian'
  sig = '7B0F AB3A 13B9 0743 5925  D9C9 5442 2A4B 98AB 5139'
  requires 'keyed apt source'.with(
    uri: url,
    key_uri: key,
    key_sig: sig,
    release: 'trusty',
    repo: 'contrib'
  )
  installs 'virtualbox'
  provides 'vboxmanage >= 4.3'
end
