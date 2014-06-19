dep 'deb package', :url, :exec, :temp_file do
  @temp_file = "/tmp/#{temp_file}"

  met? { in_path? exec }
  meet do
    cmd = "curl #{url} -sL -o #{@temp_file}"
    log_shell("Downloading #{url}", cmd) unless @temp_file.p.exist?
    sudo "dpkg --install #{@temp_file}"
  end
end
