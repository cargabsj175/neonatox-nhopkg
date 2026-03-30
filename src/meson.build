# Configurar nhopkg.in → nhopkg
nhopkg_script = configure_file(
  input: 'nhopkg.in',
  output: 'nhopkg',
  configuration: conf
)

# Configurar scripts adicionales en /usr/bin
nhopkg_repos = configure_file(
  input: 'nhopkg-repos.in',
  output: 'nhopkg-repos',
  configuration: conf
)

nhouser = configure_file(
  input: 'nhouser.in',
  output: 'nhouser',
  configuration: conf
)

nhopkg_overlay = configure_file(
  input: 'nhopkg-overlay.in',
  output: 'nhopkg-overlay',
  configuration: conf
)

# Configurar librería en /usr/lib/nhopkg
libnhopkg = configure_file(
  input: 'libnhopkg.in',
  output: 'libnhopkg',
  configuration: conf
)

# Instalar los scripts ejecutables
install_data(
  [nhopkg_script, nhopkg_repos, nhouser, nhopkg_overlay],
  install_dir: get_option('bindir'),
  install_mode: 'rwxr-xr-x'
)

# Instalar librería en libdir/nhopkg (/usr/lib/nhopkg)
install_data(
  libnhopkg,
  install_dir: join_paths(get_option('libdir'), 'nhopkg'),
  install_mode: 'rw-r--r--'
)

# Configurar nhopkg.conf.in → nhopkg.conf
nhopkg_conf = configure_file(
  input: 'nhopkg.conf.in',
  output: 'nhopkg.conf',
  configuration: conf
)

# Instalar archivo de configuración en /etc/nhopkg/
install_data(
  nhopkg_conf,
  install_dir: join_paths(get_option('sysconfdir'), 'nhopkg')
)
