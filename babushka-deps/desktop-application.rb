dep 'desktop-application',
  :version, :type, :app_name, :exec, :comment,
  :categories, :generic_name, :icon, :app_binary do
  version.default! '1.0'
  type.default! 'Application'
  generic_name.default! app_name
  comment.default! app_name
  app_binary.default! app_name.to_s.downcase
  exec.default! which(app_binary)
  icon.default! ''

  @desktop_file_content = %Q|
[Desktop Entry]
Version=#{version}
Encoding=UTF-8
Type=#{type}
Name=#{app_name}
Exec=#{exec}
Icon=#{icon}
Comment=#{comment}
Categories=#{categories}
Terminal=false
StartupNotify=false
GenericName=#{generic_name}
|
  @desktop_file = "/usr/share/applications/#{app_binary}.desktop"

  met? { File.exists? @desktop_file }
  meet {
    sudo("cat > #{@desktop_file}", :input => @desktop_file_content)
    log "Created desktop file for: #{app_name}"
  }
end

