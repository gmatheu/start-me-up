dep 'sublime' do
  requires 'subl.managed'
end

dep 'subl.managed' do
  requires 'ppa'.with('ppa:webupd8team/sublime-text-3')
  installs 'sublime-text-installer'
  provides 'subl >= 3059'
end
