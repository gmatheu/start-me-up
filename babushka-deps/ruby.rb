dep 'ruby' do
  requires 'rvm', 'ruby.bin', 'default gems'
end

dep 'ruby.bin' do
  requires 'rvm'
  provides 'ruby >= 1.9.3'
  meet {
    shell 'rvm install 2.1.1'
    shell 'rvm use --default 2.1.1'
  }
end
dep 'rvm' do
  met? { which('rvm') }

  meet {
    shell 'bash -c "`curl -sL https://get.rvm.io`"'
    shell 'bash -c "source ~/.rvm/scripts/rvm; rvm notes"'
    # profile = Dir["~/.bash_profile", "~/.bashrc"].first || "~/.bash_profile"
    # shell "echo 'if [[ -s \"$HOME/.rvm/scripts/rvm\" ]] ; then source \"$HOME/.rvm/scripts/rvm\" ; fi' >> #{profile}"
  }
end

GEMS = ['pry', 'guard'].map{ |g| "#{g}.gem" }
dep 'default gems' do
  requires GEMS
end
GEMS.each{ |g| dep g }
