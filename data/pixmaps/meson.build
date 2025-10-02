# data/pixmaps/meson.build

icon_name_bin = 'application-x-nho.png'
icon_name_src = 'application-x-nho-src.png'

# Instalar en múltiples tamaños (el sistema elegirá el más adecuado)
foreach size : ['16x16', '32x32', '48x48', '64x64', '128x128', '256x256', '512x512']
  install_data(
    'nhopkg.png',
    install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', size, 'mimetypes'),
    rename: icon_name_bin
  )
  install_data(
    'nhopkg.png',
    install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', size, 'mimetypes'),
    rename: icon_name_src
  )
endforeach
