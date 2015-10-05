dep 'deb package', :url, :exec, :temp_file, :version do
  @temp_file = "/tmp/#{temp_file}"
  met? do
    in_path?(exec) &&
      (shell("dpkg -p #{exec} | grep Version").include?(version) ||
       versionFromCmd("#{exec} --version").version <= paramToVersion(version))
  end
  meet do
    cmd = "curl #{url} -sL -o #{@temp_file}"
    log_shell("Downloading #{url}", cmd) unless @temp_file.p.exist?
    sudo "dpkg --install #{@temp_file}"
  end
end
