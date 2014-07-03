dep 'nodejs' do
  requires 'nodejs.managed'
  requires 'json.npm'
end

dep 'nodejs.managed' do
  requires 'ppa'.with('ppa:chris-lea/node.js')
  installs 'nodejs'
  provides 'node', 'npm'
end

dep 'json.npm' do
  met? { which 'json'}
  meet { sudo 'npm install -g json' }
end
