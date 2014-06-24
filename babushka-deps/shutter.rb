dep 'shutter' do
  requires 'shutter.managed'
end

dep 'shutter.managed' do
  requires 'ppa'.with('ppa:shutter/ppa')
  installs 'shutter'
  provides 'shutter'
end
