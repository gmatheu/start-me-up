dep 'caffeine' do
  requires 'caffeine.managed'
end

dep 'caffeine.managed' do
  requires 'ppa'.with('ppa:caffeine-developers/ppa')
  installs 'caffeine'
  provides 'caffeine'
end
