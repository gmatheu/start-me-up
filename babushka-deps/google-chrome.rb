dep 'google-chrome.managed' do
  key = 'https://dl-ssl.google.com/linux/linux_signing_key.pub'
  url = 'http://dl.google.com/linux/chrome/deb/'
  sig = '-'
  requires 'keyed apt source'.with(
    uri: url,
    key_uri: key,
    key_sig: sig,
    release: 'stable',
    repo: 'main'
  )
  installs 'google-chrome-stable'
  provides 'google-chrome'
end
