dep 'virtualbox' do
  requires 'virtualbox.managed'
end

dep 'virtualbox.managed' do
  key = 'https://www.virtualbox.org/download/oracle_vbox_2016.asc'
  url = 'http://download.virtualbox.org/virtualbox/debian'
  sig = '2980 AECF'
  requires 'keyed apt source'.with(
    uri: url,
    key_uri: key,
    key_sig: sig,
    repo: 'contrib'
  )
  installs 'virtualbox-6.0'
  provides 'vboxmanage >= 6.0'
end
