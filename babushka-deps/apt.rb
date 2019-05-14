dep 'keyed apt source', :uri, :release, :repo, :key_sig, :key_uri do
  requires 'apt source'.with(uri, release, repo, uri)

  met? {
    spaceless_key_sig = key_sig.to_s.gsub(' ', '')
    shell("apt-key fingerprint #{spaceless_key_sig}") =~ /#{key_sig}/
  }
  meet {
    key = log_shell("Downloading #{key_uri}", 'curl', key_uri)
    log_shell("Adding #{key_sig}", 'apt-key add -', :input => key)
    Babushka::AptHelper.update_pkg_lists "Updating apt lists to load #{uri}"
  }
end

dep 'apt source', :uri, :release, :repo, :uri_matcher do
  uri.default!(Babushka::AptHelper.source_for_system)
  release.default!(Babushka.host.codename)
  uri_matcher.default!(Babushka::AptHelper.source_matcher_for_system)
  sources_line= "deb #{uri} #{release} #{repo}"
  met? {
    shell('grep -R -h \^deb /etc/apt/sources.list /etc/apt/sources.list.d/').split("\n").any? do |l|
      # e.g. deb http://au.archive.ubuntu.com/ubuntu/ natty main restricted
      l[/^deb\s+#{uri_matcher}\s+#{release}\b.*\b#{repo}\b/] or l.include?(sources_line)
    end
  }
  meet {
    log_block "Adding #{release} from #{uri}" do
      '/etc/apt/sources.list.d/babushka.list'.p.append("#{sources_line}\n")
    end

    Babushka::AptHelper.update_pkg_lists "Updating apt lists to load #{uri}."
  }
end

dep 'ppa', :spec do
  requires 'software-properties.bin'
  def spec_name
    log_error("'#{spec}' doesn't look like 'ppa:something'.") unless spec[/^ppa\:\w+/]
    spec.to_s.sub(/^ppa\:/, '')
  end
  def ppa_release_file
    # This may be hardcoded to some extent, but I'm calling YAGNI on it for now.
    "ppa.launchpad.net_#{spec_name.gsub('/', '_')}_ubuntu_dists_#{Babushka.host.codename}_Release"
  end
  met? {
    ('/var/lib/apt/lists/' / ppa_release_file).exists?
  }
  meet {
    log_shell "Adding #{spec}", "add-apt-repository '#{spec}'", :spinner => true, :sudo => true
    log_shell "Updating apt lists to load #{spec}.", "apt-get update", :sudo => true
  }
end

dep 'software-properties.bin' do
  provides 'add-apt-repository'
end
