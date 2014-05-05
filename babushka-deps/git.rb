dep 'git' do
  requires 'git.managed', 'git settings'
end

dep 'git.managed' do
  requires 'ppa'.with('ppa:git-core/ppa')
  installs 'git'
  provides 'git >= 1.9.2'
end

dep 'git settings', :commiter, :email do
  commiter.default!(ENV['FULL_NAME'] || 'My Name')
  email.default!(ENV['EMAIL'] || 'me@email.com')
  requires 'git config'.with('user.name', commiter)
  requires 'git config'.with('user.email', email)
  requires 'git config'.with('core.pager', '')
  requires 'git config'.with('color.ui', 'true')
  requires 'git config'.with('merge.tool', 'meld')
  requires 'git config'.with('diff.tool', 'meld')
end

dep 'git config', :key, :value do
  @command = "git config --global"
  met? { shell?("#{@command} #{key} | grep '#{value}'") }
  meet { shell "#{@command} --replace-all #{key} '#{value}'" }
end

dep 'ssh key', :email do
  meet { "ssh-keygen -t rsa -C #{email}" }
end
