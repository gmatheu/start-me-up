dep 'atom' do
  requires 'atom.managed'
end

dep 'atom.managed' do
  requires 'ppa'.with('ppa:webupd8team/atom')
  installs 'atom'
  # provides 'atom >= 0.9.4'
end
