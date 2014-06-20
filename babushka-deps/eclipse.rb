dep 'eclipse' do
  requires 'user-application'.with(
    app_name: 'eclipse',
    url: 'http://espelhos.edugraf.ufsc.br/eclipse//technology/epp/downloads/release/kepler/SR2-with-Java8-patches/eclipse-jee-kepler-SR2-Java8-linux-gtk-x86_64.tar.gz',
    exec: 'eclipse/eclipse',
    temp_file: 'eclipse-jee-kepler-SR2-Java8-linux-gtk-x86_64.tar.gz'
  ),
  'desktop-application'.with(
    app_name: 'Eclipse',
    comment: 'Eclipse Kepler',
    categories: 'Development;IDE;',
    generic_name: 'Eclipse Kepler',
    icon: '/opt/eclipse/icon.xpm'
  )
end
