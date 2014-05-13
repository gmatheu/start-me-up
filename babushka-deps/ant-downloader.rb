dep 'ant-downloader' do
  requires 'python-ant-downloader.pip'
end

dep 'python-ant-downloader.pip' do
  requires ['python-pip.lib', 'libusb-1.0-0.lib', 'python-lxml.lib']
  provides 'ant-downloader'
end

dep 'python-pip.lib'
dep 'libusb-1.0-0.lib'
dep 'python-lxml.lib'
