project('nhopkg', 'c',
  version: '0.5.1',
  license: 'GPL3+',
  default_options: [
    'prefix=/usr',
    'sysconfdir=/etc',
    'localstatedir=/var',
    'libdir=lib'
  ]
)

# === Opciones de configuración ===
binlocate = get_option('binlocate')
repo_url_core = get_option('repo-url-core')
repo_url_extra = get_option('repo-url-extra')
repo_url_multilib = get_option('repo-url-multilib')
git_url = get_option('git-url')

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
conf.set('NHOPKG_REPO_CORE', repo_url_core)
conf.set('NHOPKG_REPO_EXTRA', repo_url_extra)
conf.set('NHOPKG_REPO_MULTILIB', repo_url_multilib)
conf.set('NHOPKG_GIT_SOURCES', git_url)

# Variables para nhopkg.in
conf.set('PACKAGE_NAME', meson.project_name())
conf.set('PACKAGE_VERSION', meson.project_version())
conf.set('RELEASEDATE', '2026')

# === Verificación de dependencias del sistema ===
required_tools = [
  'bash', 'tar', 'zstd', 'bsdtar', 'sha256sum', 'make',
  'grep', 'awk', 'sed', 'find', 'wget'
]

optional_tools = [
  'curl', 'gpg', 'ldconfig', 'gettext', '7z', 'git', 'svn', 'hg'
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

# Herramientas para gestión de traducciones
xgettext_prog = find_program('xgettext', required: false)
msgmerge_prog = find_program('msgmerge', required: false)
msginit_prog = find_program('msginit', required: false)

# === Subdirectorios ===
subdir('src')
subdir('data')
subdir('po')
