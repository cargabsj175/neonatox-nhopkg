# Configurar nhopkg.in → nhopkg
nhopkg_script = configure_file(
  input: 'nhopkg.in',
  output: 'nhopkg',
  configuration: conf
)

# Instalar el script ejecutable
install_data(
  nhopkg_script,
  install_dir: get_option('bindir'),
  install_mode: 'rwxr-xr-x'
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
