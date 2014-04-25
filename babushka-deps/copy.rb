dep 'copy' do
  @download_url = 'https://copy.com/install/linux/Copy.tgz'
  @temp_file = '/tmp/Copy.tgz'
  @desktop_file_content = %Q|
  [Desktop Entry]
  Version=1.0
  Encoding=UTF-8
  Type=Application
  Name=Copy
  Exec=/usr/bin/copy
  Comment=Sync your files across computers and to the web
  Categories=Network;FileTransfer;
  Terminal=false
  StartupNotify=false
  GenericName=File Synchronizer
  |

  met? do
    in_path? 'copy'
  end

  meet do
    shell "curl #{@download_url} -o #{@temp_file}" unless @temp_file.p.exist?
    sudo "tar -xf #{@temp_file} -C /opt"
    sudo 'ln -s /opt/copy/x86_64/CopyAgent /usr/bin/copy'

    sudo("cat > /usr/share/applications/copy.desktop", :input => @desktop_file_content)
  end
end
