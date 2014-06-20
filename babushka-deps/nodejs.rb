dep 'nodejs' do
  requires 'nodejs.managed'
end

dep 'nodejs.managed' do
  requires 'ppa'.with('ppa:chris-lea/node.js')
  installs 'nodejs'
  provides 'node', 'npm'
end
