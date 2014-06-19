dep 'user-application', :app_name, :url, :exec, :temp_file do
  @temp_file = "/tmp/#{temp_file}"

  met? { in_path? app_name }
  meet do
    cmd = "curl #{url} -o #{@temp_file}"
    log_shell("Downloading #{url}", cmd) unless @temp_file.p.exist?
    sudo "tar -xf #{@temp_file} -C /opt"
    sudo "ln -sf /opt/#{exec} /usr/local/bin/#{app_name}"
  end
end
