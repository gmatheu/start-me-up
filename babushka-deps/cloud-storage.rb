dep 'cloud-storage' do
  requires 'grive.managed'
end

dep 'grive.managed' do
  requires 'ppa'.with('ppa:nilarimogard/webupd8')
  installs 'grive'
  #  provides 'grive'
end
