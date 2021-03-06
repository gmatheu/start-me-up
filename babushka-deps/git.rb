dep 'git' do
  requires 'git.managed', 'git settings', 'ssh key'
end

dep 'git.managed' do
  requires 'ppa'.with('ppa:git-core/ppa')
  installs 'git'
  provides 'git >= 1.9.2'
end

dep 'git settings', :commiter, :email do
  commiter.default!(ENV['FULL_NAME']) if ENV['FULL_NAME']
  email.default!(ENV['EMAIL']) if ENV['EMAIL']
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
  email.default!(ENV['EMAIL']) if ENV['EMAIL']
  @file = File.expand_path '~/.ssh/id_rsa'
  met? { File.exist? @file }
  meet { shell "ssh-keygen -t rsa -f #{@file} -C #{email}" }
end
