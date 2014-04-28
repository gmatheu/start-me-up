dep 'dotfile.symlink', :dotfile, :destination, :home do
  destination.default! '~'
  source File.expand_path "#{home}/#{dotfile}"
  target File.expand_path "#{destination}/.#{dotfile}"
end

meta :symlink do
    accepts_value_for :source
    accepts_value_for :target

    template {
      met? { File.exists?(target) && File.symlink?(target) }
      meet {
        log "Creating symlink: #{target}"
        File.rename target, "#{target}.stu" if File.exists?(target)
        File.symlink source, target
      }
    }
end

