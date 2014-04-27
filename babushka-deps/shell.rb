dep 'shell' do
  requires [
    'zsh.bin',
    'zsh shell'
  ]
  @home = '~/.oh-my-zsh'

  met? {
    @home.p.exist?
  }

  meet {
    shell `curl -L http://install.ohmyz.sh | sh`
  }
end

dep 'zsh shell' do
  requires 'zsh.bin'
  met? {
    # sudo "su #{current_username} -c 'echo $0 | grep zsh'"
    shell("sudo su - '#{current_username}' -c 'echo $SHELL'") == which('zsh')
  }
  meet {
    sudo "chsh -s '#{which('zsh')}' #{current_username}"
  }
end

dep 'zsh.bin'
