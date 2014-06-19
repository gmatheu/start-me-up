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
  requires 'user-application'.with(
    app_name: 'copy',
    url: 'https://copy.com/install/linux/Copy.tgz',
    exec: 'copy/x86_64/CopyAgent',
    temp_file: 'Copy.tgz'
  ),
  'desktop-application'.with(
    app_name: 'Copy',
    comment: 'Sync your files across computers and to the web',
    categories: 'Network;FileTransfer;',
    generic_name: 'File Synchronizer'
  )
end
