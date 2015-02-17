dep 'spotify' do
  met? do
    which 'spotify'
  end

  meet do
    sudo 'echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list'
    sudo 'apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59'
    sudo 'apt-get update'
    sudo 'apt-get install -y spotify-client'
  end
end
