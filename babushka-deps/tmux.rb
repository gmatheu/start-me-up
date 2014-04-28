dep 'tmux', :home do
  requires 'tmux.bin'
  requires 'dotfile.symlink'.with(dotfile: 'tmux.conf', home: home / 'dotfiles')
end

dep 'tmux.bin'
