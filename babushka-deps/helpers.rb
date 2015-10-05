include Babushka

def versionFromCmd cmd
  VersionOf shell(cmd)
end

def paramToVersion param
  VersionStr.new param.to_s
end
