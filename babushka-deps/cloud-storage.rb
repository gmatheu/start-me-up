dep 'cloud-storage' do
  requires 'copy', 'grive.managed', 'grive-tools.managed'
end

dep 'grive.managed' do
  requires 'ppa'.with('ppa:nilarimogard/webupd8')
  installs 'grive'
  provides 'grive'
end

dep 'grive-tools.managed' do
  requires 'ppa'.with('ppa:thefanclub/grive-tools')
  installs 'grive-tools'
  provides []
end

dep 'copy' do
  requires 'copy.bin', 'desktop-application'.with(
    app_name: 'Copy',
    comment: 'Sync your files across computers and to the web',
    categories: 'Network;FileTransfer;',
    generic_name: 'File Synchronizer'
  )
end

dep 'copy.bin' do
  @download_url = 'https://copy.com/install/linux/Copy.tgz'
  @temp_file = '/tmp/Copy.tgz'

  met? { in_path? 'copy' }
  meet do
    shell "curl #{@download_url} -o #{@temp_file}" unless @temp_file.p.exist?
    sudo "tar -xf #{@temp_file} -C /opt"
    sudo 'ln -s /opt/copy/x86_64/CopyAgent /usr/local/bin/copy'
  end
end


