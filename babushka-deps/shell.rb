OH_MY_ZSH_HOME = '~/.oh-my-zsh'
OH_MY_ZSH_CUSTOM = "#{OH_MY_ZSH_HOME}/custom"

dep 'shell', :home do
  requires [
    'zsh.bin',
    'zsh shell',
    ['zshrc', 'zshenv'].map { |d|
      'dotfile.symlink'.with(dotfile: d, home: home / 'dotfiles')
    },
    ['functions', 'extra-init'].map { |f|
      'oh-my-zsh custom.symlink'.with(source_dir: home / 'custom-files', custom_file: f)
    },
    'oh-my-zsh',
    'zsh-syntax-highlighting'
  ].flatten
end

dep 'zsh-syntax-highlighting' do
  requires 'oh-my-zsh'
  @repo = 'https://github.com/zsh-users/zsh-syntax-highlighting.git'
  @path = "#{OH_MY_ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
  met? { Babushka::GitRepo.repo_for(@path).exists? }
  meet { git @repo, :to => @path }
end

dep 'oh-my-zsh' do
  @home = OH_MY_ZSH_HOME
  met? { @home.p.exist? }
  meet { shell `curl -L http://install.ohmyz.sh | sh` }
end

dep 'oh-my-zsh custom.symlink', :custom_file, :source_dir do
  source File.expand_path "#{source_dir}/#{custom_file}.zsh"
  target File.expand_path "#{OH_MY_ZSH_CUSTOM}/#{custom_file}.zsh"
end

dep 'zsh shell' do
  requires 'zsh.bin'
  met? { shell("sudo su - '#{current_username}' -c 'echo $SHELL'") == which('zsh') }
  meet { sudo "chsh -s '#{which('zsh')}' #{current_username}" }
end

dep 'dotfile.symlink', :dotfile, :destination, :home do
  destination.default! '~'
  source File.expand_path "#{home}/#{dotfile}"
  target File.expand_path "#{destination}/.#{dotfile}"
end

meta :symlink do
    accepts_value_for :source
    accepts_value_for :target

    template {
      met? { File.exists?(target) && File.symlink?(target) }
      meet {
        log "Creating symlink: #{target}"
        File.rename target, "#{target}.stu" if File.exists?(target)
        File.symlink source, target
      }
    }
end

dep 'zsh.bin'
