dep 'skype' do
  requires 'skype.managed'
end

dep 'skype.managed' do
  requires 'canonical partner repository'
  installs 'skype'
  provides 'skype >= 4.3'
end

dep 'canonical partner repository' do
  url = 'http://archive.canonical.com/ubuntu/'
  requires 'apt source'.with(
    uri: url,
    release: 'trusty',
    repo: 'partner'
  )
end
