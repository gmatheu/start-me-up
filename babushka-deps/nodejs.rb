dep 'nodejs' do
  requires 'nodejs.managed'
  requires 'json.npm'
end

dep 'nodejs.managed' do
  requires 'ppa'.with('ppa:chris-lea/node.js')
  installs 'nodejs'
  provides 'node', 'npm'
end

dep 'json.npm'

meta :npm do
    template {
      @name = name.split('.').first
      requires 'nodejs.managed'
      met? { which "#{@name}" }
      meet { sudo "npm install -g #{@name}" }
    }
end
