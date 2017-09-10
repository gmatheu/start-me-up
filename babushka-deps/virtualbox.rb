dep 'virtualbox' do
  requires 'virtualbox-5.1.managed'
end

dep 'virtualbox-5.1.managed' do
  key = 'https://www.virtualbox.org/download/oracle_vbox_2016.asc'
  url = 'http://download.virtualbox.org/virtualbox/debian'
  sig = 'B9F8 D658 297A F3EF C18D  5CDF A2F6 83C5 2980 AECF'
  requires 'keyed apt source'.with(
    uri: url,
    key_uri: key,
    key_sig: sig,
    release: 'xenial',
    repo: 'contrib'
  )
  installs 'virtualbox'
  provides 'vboxmanage >= 5.1'
end
