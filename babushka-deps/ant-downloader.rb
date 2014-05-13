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

# Add configuration file ~/.antd/antd.cfg
# Add /etc/udev/rules.d/99-garmin.rules with SUBSYSTEM=="usb", ATTR{idVendor}=="0fcf", ATTR{idProduct}=="1008", MODE="666"
