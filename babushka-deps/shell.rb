dep 'shell' do
  requires [ 'zsh.bin' ]
  log 'To customize zsh, use: https://github.com/gmatheu/dotfiles'
  log 'By running: curl -sL https://raw.githubusercontent.com/gmatheu/dotfiles/master/install.sh | sh'
end

dep 'zsh.bin'
