JAVA_PACKAGES = %Q|
openjdk-7-source
openjdk-7-doc
openjdk-7-jdk
maven
gradle
|.split.map{ |p| "#{p}.lib" }

dep 'java' do
  requires JAVA_PACKAGES
  requires 'oracle java.managed'
end

dep 'oracle java.managed' do
  requires 'ppa'.with('ppa:webupd8team/java')
  installs []
  log 'You can install: oracle-java7-installer'
  log 'You can install: oracle-java8-installer'
end

JAVA_PACKAGES.each{ |p| dep p }
