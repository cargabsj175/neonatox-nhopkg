# Página de manual nhopkg.8
man8 = configure_file(
  input: 'nhopkg.8.in',
  output: 'nhopkg.8',
  configuration: conf
)
install_data(man8, install_dir: join_paths(get_option('datadir'), 'man', 'man8'))

# Página de manual nhopkg.conf.5
man5 = configure_file(
  input: 'nhopkg.conf.5.in',
  output: 'nhopkg.conf.5',
  configuration: conf
)
install_data(man5, install_dir: join_paths(get_option('datadir'), 'man', 'man5'))

# Archivo MIME
install_data('x-nho.xml', install_dir: join_paths(get_option('datadir'), 'mime', 'packages'))

# Iconos
subdir('pixmaps')
