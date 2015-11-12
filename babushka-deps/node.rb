NVM_DEFAULT_VERSION='0.29.0'
NODE_DEFAULT_VERSION='5.0.0'

nvm_command = ->(cmd) {
  "bash -c 'source ~/.nvm/nvm.sh; nvm #{cmd}'"
}

dep 'node' do
  requires 'nvm'
  met? {
    shell(nvm_command.call('list node')) =~ /#{NODE_DEFAULT_VERSION}/
  }
  meet {
    shell nvm_command.call('install node')
    shell nvm_command.call('alias default node')
  }
end
dep 'nvm', :version do
  version.default! NVM_DEFAULT_VERSION
  met? {
    shell(nvm_command.call('--version')) =~ /#{version}/
  }

  meet {
    shell "curl -o- https://raw.githubusercontent.com/creationix/nvm/v#{NVM_DEFAULT_VERSION}/install.sh | bash"
  }
end
