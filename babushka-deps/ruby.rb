dep 'ruby' do
  requires 'rvm load', 'ruby.bin', 'rvm ruby', 'default gems'
end

dep 'ruby.bin' do
  provides 'ruby >= 1.9.3p484'
end

dep 'rvm' do
  met? { which('rvm') }

  meet {
    shell 'bash -c "`curl -sL https://get.rvm.io`"'
    shell 'bash -c "source ~/.rvm/scripts/rvm; rvm notes"'
  }
end
dep 'rvm ruby' do
  rvm_command = ->(cmd) {
    "bash -c 'source ~/.rvm/scripts/rvm; rvm #{cmd}'"
  }
  requires 'rvm'
  met? {
    shell(rvm_command.call('current')) =~ /2.1.1/
  }
  meet {
    shell rvm_command.call 'install 2.1.1'
    shell rvm_command.call 'use --default 2.1.1'
  }
end

dep 'rvm load' do
  requires 'rvm'
  profile = File.expand_path '~/.profile'
  sentence = '[ -s ~/.rvm/scripts/rvm ] && source ~/.rvm/scripts/rvm'
  met? {
    File.open(profile).lines.any? do |line|
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
