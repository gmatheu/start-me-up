dep 'heroku' do
  requires 'heroku.bin'
end

dep 'heroku.bin' do
  meet {
    sudo 'curl https://toolbelt.heroku.com/install-ubuntu.sh | sh'
  }
  provides [
    'heroku >= 3.7',
    'foreman >= 0.63'
  ]
end
