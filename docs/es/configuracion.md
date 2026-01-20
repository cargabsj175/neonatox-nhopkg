[← Índice](index.md)

# 2\. Configuración

El archivo de configuración principal de **nhopkg** es:
    
    
    /etc/nhopkg/nhopkg.conf

Si no existe, se carga una configuración por defecto desde:
    
    
    /usr/share/nhopkg/nhopkg.conf

Todas las variables definidas en este archivo pueden ser anuladas temporalmente mediante opciones de línea de comandos.

## Variables principales

### Rutas y directorios

Variable | Valor por defecto | Descripción  
---|---|---  
`NHOPKG_LOCALSTATEDIR` | `/var/nhopkg` | Directorio base para metadatos, caché y logs.  
`NHOPKG_BUILDIR` | `/usr/src/nhopkg` | Directorio donde se compilan los paquetes fuente.  
`NHOPKG_LOCKFILE` | `/var/lock/nhopkg` | Archivo de bloqueo para evitar ejecuciones concurrentes.  
`NHOPKG_DB` | `/var/nhopkg/nhopkg.db` | Base de datos local usada por `locate` para resolver dependencias por archivo.  
  
### Opciones generales

Variable | Valores | Descripción  
---|---|---  
`NHOPKG_CHECKDEPS` | `yes` / `no` | Verifica dependencias antes de instalar (por defecto: `yes`).  
`NHOPKG_CHECKSHA256` | `yes` / `no` | Verifica el checksum SHA256 de los paquetes (por defecto: `yes`).  
`NHOPKG_CHECKARCH` | `yes` / `no` | Verifica que la arquitectura del paquete coincida con el sistema (por defecto: `yes`).  
`NHOPKG_PURGE` | `yes` / `no` | Al desinstalar, elimina también paquetes que dependen del objetivo (por defecto: `no`).  
`VERBOSE_MODE` | `yes` / `no` | Modo verboso durante compilación e instalación (por defecto: `no`).  
`STRIP_BINARIES` | `yes` / `no` | Elimina símbolos de depuración de binarios al empaquetar (experimental, por defecto: `no`).  
  
### Firmas GPG

Variable | Valor por defecto | Descripción  
---|---|---  
`NHOPKG_TRUSTED_KEYS_DIR` | `/etc/nhopkg/trusted-keys/` | Directorio del keyring de confianza para verificación de firmas.  
`NHOPKG_SIGN_PACKAGES` | `yes` | Firma los paquetes binarios al construirlos (solo para mantenedores).  
`NHOPKG_SIGN_KEY` | `repo@neonatox.vegnux.com` | Clave GPG predeterminada para firmar paquetes.  
`NHOPKG_VERIFY_SIGNATURE` | `yes` | Verifica la firma GPG de los paquetes antes de instalarlos.  
`NHOPKG_REQUIRE_SIGNATURE` | `no` | Exige que todos los paquetes estén firmados (requiere `NHOPKG_VERIFY_SIGNATURE=yes`).  
  
### Repositorios

Variable | Ejemplo | Descripción  
---|---|---  
`NHOPKG_ACTIVE_REPOS` | `extra multilib` | Lista de repositorios activos (separados por espacios).  
`NHOPKG_REPO_EXTRA` | `https://neonatox.vegnux.com/repo/n2026/x86_64/extra` | URL(s) del repositorio `extra` (admite múltiples mirrors separados por espacios).  
`NHOPKG_REPO_MULTILIB` | `https://neonatox.vegnux.com/repo/n2026/x86_64/multilib` | URL(s) del repositorio `multilib`.  
`NHOPKG_GIT_SOURCES` | `https://gitlab.com/neonatox-sources` | URL base para clonar repositorios Git al usar `--super-build`.  
  
### Construcción de paquetes

Variable | Valor por defecto | Descripción  
---|---|---  
`FIND_DIRS` | `/bin /boot /etc /lib /opt /sbin /srv /usr` | Directorios donde `nhopkg` busca archivos instalados al generar paquetes binarios.  
`NOUPGRADE_FILES` | `/etc/ld.so.cache mimeinfo.cache info/dir ...` | Archivos que se excluyen del paquete binario generado (archivos generados en tiempo de ejecución).  
`NO_DIRS_IN_DB` | `/dev /home /media /mnt /proc /run /sys /tmp ...` | Directorios excluidos de la base de datos local (`updatedb`).  
  
## Prioridad de configuración

Los valores se aplican en este orden (el último tiene mayor prioridad):

  1. Archivo de configuración: `/etc/nhopkg/nhopkg.conf`
  2. Opciones de línea de comandos (ej. `--no-check-deps`)



## Ejemplo mínimo
    
    
    # Repositorios activos
    NHOPKG_ACTIVE_REPOS="extra"
    
    # URL del repositorio
    NHOPKG_REPO_EXTRA="https://mi-repo.example.com/nhopkg/x86_64/extra"
    
    # Desactivar verificación de firmas (solo para desarrollo)
    NHOPKG_VERIFY_SIGNATURE=no
    
