dep 'idea' do
  requires 'intellij idea ultimate'
end

dep 'intellij idea ultimate' do
  requires 'user-application'.with(
    app_name: 'idea',
    url: 'http://download.jetbrains.com/idea/ideaIU-13.1.3.tar.gz',
    exec: 'eclipse/eclipse',
    temp_file: 'ideaIU-13.1.3.tar.gz'
  ),
  'desktop-application'.with(
    app_name: 'Idea',
    comment: 'IntelliJ Idea 13',
    categories: 'Development;IDE;',
    generic_name: 'Idea 13',
    icon: ''
  )
end
