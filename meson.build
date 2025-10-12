project('nhopkg', 'c',
  version: '0.5.1',
  license: 'GPL3+',
  default_options: [
    'prefix=/usr',
    'sysconfdir=/etc',
    'localstatedir=/var'
  ]
)

# === Opciones de configuración ===
binlocate = get_option('binlocate')
repo_url = get_option('repo-url')

# === Configuración para sustitución en archivos .in ===
conf = configuration_data()

# Variables estándar de Meson
conf.set('prefix', get_option('prefix'))
conf.set('sysconfdir', get_option('sysconfdir'))
conf.set('localstatedir', get_option('localstatedir'))
conf.set('datadir', get_option('datadir'))

# Variables derivadas
pkgdatadir = join_paths(get_option('datadir'), meson.project_name())
conf.set('pkgdatadir', pkgdatadir)
conf.set('localedir', join_paths(get_option('prefix'), 'share', 'locale'))

# Variables para nhopkg.conf.in
conf.set('datarootdir', join_paths(get_option('prefix'), get_option('datadir')))
conf.set('PACKAGE', meson.project_name())
conf.set('NHOPKG_REPO', repo_url)

# Variables para nhopkg.conf.in
conf.set('datarootdir', join_paths(get_option('prefix'), get_option('datadir')))
conf.set('PACKAGE', meson.project_name())
conf.set('NHOPKG_GIT_SOURCES', repo_git_sources)

# Variables para nhopkg.in
conf.set('PACKAGE_NAME', meson.project_name())
conf.set('PACKAGE_VERSION', meson.project_version())
conf.set('RELEASEDATE', '2026')

# === Verificación de dependencias del sistema ===
required_tools = [
  'bash', 'tar', 'zstd', 'sha256sum', 'make',
  'grep', 'awk', 'sed', 'find'
]

optional_tools = [
  'wget', 'curl', 'git', 'ldconfig', 'gettext'
]

# Verificar herramientas requeridas
foreach tool : required_tools
  find_program(tool, required: true)
endforeach

# Verificar binlocate
find_program(binlocate == 'plocate' ? 'plocate' : 'locate', required: true)

# Advertir sobre herramientas opcionales
foreach tool : optional_tools
  if not find_program(tool, required: false).found()
    message('Advertencia: herramienta opcional no encontrada: ' + tool)
  endif
endforeach

# === Subdirectorios ===
subdir('src')
subdir('data')
subdir('po')
