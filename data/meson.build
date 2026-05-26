# nhoget.8 man page
man_nhoget8 = configure_file(
  input: 'nhoget.8.in',
  output: 'nhoget.8',
  configuration: conf
)
install_data(man_nhoget8, install_dir: join_paths(get_option('datadir'), 'man', 'man8'))

# nhopkg.8 man page
man8 = configure_file(
  input: 'nhopkg.8.in',
  output: 'nhopkg.8',
  configuration: conf
)
install_data(man8, install_dir: join_paths(get_option('datadir'), 'man', 'man8'))

# nhopkg-src.8 man page
man_src8 = configure_file(
  input: 'nhopkg-src.8.in',
  output: 'nhopkg-src.8',
  configuration: conf
)
install_data(man_src8, install_dir: join_paths(get_option('datadir'), 'man', 'man8'))

# nhopkg-repos.8 man page
man_repos8 = configure_file(
  input: 'nhopkg-repos.8.in',
  output: 'nhopkg-repos.8',
  configuration: conf
)
install_data(man_repos8, install_dir: join_paths(get_option('datadir'), 'man', 'man8'))

# nhouser.8 man page
man_nhouser8 = configure_file(
  input: 'nhouser.8.in',
  output: 'nhouser.8',
  configuration: conf
)
install_data(man_nhouser8, install_dir: join_paths(get_option('datadir'), 'man', 'man8'))

# nhopkg-overlay.8 man page
man_overlay8 = configure_file(
  input: 'nhopkg-overlay.8.in',
  output: 'nhopkg-overlay.8',
  configuration: conf
)
install_data(man_overlay8, install_dir: join_paths(get_option('datadir'), 'man', 'man8'))

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
install_data('trusted-keys/nhopkg-repo.pub', install_dir: trusted_keys_dir)
