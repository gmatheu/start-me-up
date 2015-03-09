JAVA_PACKAGES = %Q|
openjdk-7-source
openjdk-7-doc
openjdk-7-jdk
maven
|.split.map{ |p| "#{p}.lib" }

dep 'java' do
  requires JAVA_PACKAGES
  requires 'oracle java.managed', 'openjdk.managed', 'gradle.managed'
end

dep 'oracle java.managed' do
  requires 'ppa'.with('ppa:webupd8team/java')
  installs []
  log 'You can install: oracle-java7-installer'
  log 'You can install: oracle-java8-installer'
  log 'You can install: oracle-java9-installer'
end

dep 'openjdk.managed' do
  requires 'ppa'.with('ppa:openjdk-r/ppa')
  installs ['openjdk-8-jdk']
  met? do
    File.exists? '/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/java'
  end
end

JAVA_PACKAGES.each{ |p| dep p }

dep 'gradle.managed' do
  requires 'ppa'.with('ppa:cwchien/gradle')
  installs 'gradle'
  provides 'gradle'
end
