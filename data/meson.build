# nhopkg.8 man page
man8 = configure_file(
  input: 'nhopkg.8.in',
  output: 'nhopkg.8',
  configuration: conf
)
install_data(man8, install_dir: join_paths(get_option('datadir'), 'man', 'man8'))

# nhopkg.conf.5 man page
man5 = configure_file(
  input: 'nhopkg.conf.5.in',
  output: 'nhopkg.conf.5',
  configuration: conf
)
install_data(man5, install_dir: join_paths(get_option('datadir'), 'man', 'man5'))

# MIME file
install_data('x-nho.xml', install_dir: join_paths(get_option('datadir'), 'mime', 'packages'))

# Icons
subdir('pixmaps')

# Install the trusted public key
trusted_keys_dir = join_paths(get_option('sysconfdir'), 'nhopkg', 'trusted-keys')
install_data('trusted-keys/nhopkg-repo.pub', install_dir: trusted_keys_dir
)
