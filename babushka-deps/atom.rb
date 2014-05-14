APMS = [
  'xml-formatter',
  'monokai',
  'language-haml'
]

dep 'atom' do
  requires 'atom.managed'
  requires APMS.map { |p| "#{p}" }
end

dep 'atom.managed' do
  requires 'ppa'.with('ppa:webupd8team/atom')
  installs 'atom'
  provides 'atom', 'apm'
end

APMS.each {|p| dep p, template: 'apm'}

meta :apm do
    template {
      requires 'atom.managed'
      met? { shell? "apm list | grep '#{name}'" }
      meet {
        log "Installing #{name} apm package"
        shell "apm install #{name}"
      }
    }
end

