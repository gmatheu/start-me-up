dep 'lighttable', :version do
  version.default!('0.6.6')
  requires 'user-application'.with(
    app_name: 'lighttable',
    url: "https://d35ac8ww5dfjyg.cloudfront.net/playground/bins/#{version}/LightTableLinux64.tar.gz",
    exec: 'LightTable/LightTable',
    temp_file: "LightTableLinux64-#{version}.tar.gz"
  ),
  'desktop-application'.with(
    app_name: 'LightTable',
    version: version,
    categories: 'Development;IDE;',
    icon: '/opt/LightTable/core/img/lticon.png'
  )
end
