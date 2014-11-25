RVM_DEFAULT_VERSION='1.26.3'
RVM_RUBY_VERSION='2.1.5'

dep 'ruby' do
  requires 'rvm load', 'ruby.bin', 'rvm ruby', 'default gems'
end

dep 'ruby.bin' do
  provides 'ruby >= 1.9.3p484'
end

rvm_command = ->(cmd) {
  "bash -c 'source ~/.rvm/scripts/rvm; rvm #{cmd}'"
}

dep 'rvm', :version do
  version.default! RVM_DEFAULT_VERSION
  met? {
    shell(rvm_command.call('version')) =~ /#{version}/
  }

  meet {
    shell 'gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3'
    shell 'curl -sSL https://get.rvm.io | bash -s stable'
    shell 'bash -c "source ~/.rvm/scripts/rvm; rvm notes"'
  }
end

dep 'rvm ruby', :version do
  version.default! RVM_RUBY_VERSION
  requires 'rvm'
  met? {
    shell(rvm_command.call('current')) =~ /#{version}/
  }
  meet {
    shell rvm_command.call "install #{version}"
    shell rvm_command.call "use --default #{version}"
  }
end

dep 'rvm load' do
  requires 'rvm'
  profile = File.expand_path '~/.profile'
  sentence = '[ -s ~/.rvm/scripts/rvm ] && source ~/.rvm/scripts/rvm'
  met? {
    File.open(profile).each_line.any? do |line|
      line.include? sentence
    end
  }
  meet {
    File.open(profile, 'a') do |f|
      f.puts sentence
    end
  }
end

GEMS = ['pry', 'guard'].map{ |g| "#{g}.gem" }
dep 'default gems' do
  requires GEMS
end
GEMS.each{ |g| dep g }
