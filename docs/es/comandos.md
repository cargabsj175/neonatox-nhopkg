[← Índice](index.html)

# 4\. Comandos principales

**nhopkg** ofrece una amplia gama de comandos para gestionar paquetes binarios y fuentes. A continuación se listan todos los comandos disponibles, sus alias y su propósito.

Comando | Alias | Descripción  
---|---|---  
`-i, --install` |  | Instala un paquete binario local (`.nho`).  
`-S, --super-install` | `-d, --dios` | Instala un paquete desde un repositorio remoto.  
`-r, --remove` |  | Desinstala un paquete instalado por nhopkg.  
`-b, --build` |  | Compila e instala un paquete fuente local (`.srcnho`).  
`-C, --super-build` |  | Clona un repositorio Git, compila e instala un paquete desde fuentes remotas.  
`-B, --backup` |  | Reconstruye un paquete binario (`.nho`) a partir de uno ya instalado.  
`-y, --upgrade` |  | Actualiza todos los paquetes instalados a sus últimas versiones disponibles en los repositorios.  
`-G, --install-group` |  | Instala todos los paquetes pertenecientes a un grupo lógico (definido en el campo `# Group:` del `nhoid`).  
`-g, --create-repo` |  | Crea un repositorio de paquetes a partir de un directorio que contiene archivos `.nho`.  
`-U, --update` |  | Sincroniza los repositorios locales con los servidores remotos.  
`-l, --list` |  | Lista todos los paquetes instalados en el sistema.  
`-n, --info` |  | Muestra información detallada de un paquete (instalado, en repositorio o archivo local).  
`-w, --show` |  | Muestra la lista de archivos contenidos en un paquete.  
`-s, --search` |  | Busca paquetes en los repositorios por nombre o descripción.  
`-t, --list-repo` |  | Lista todos los paquetes disponibles en los repositorios locales sincronizados.  
`-k, --check` |  | Verifica la integridad de un paquete instalado (comprueba que todos sus archivos existen).  
`-x, --update-shooters` |  | Actualiza cachés del sistema: esquemas GLib, iconos, entradas de escritorio, tipos MIME, man pages, fuentes y bibliotecas compartidas.  
`-u, --update-db` |  | Actualiza la base de datos local usada por `locate` para resolver dependencias por archivo.  
`-e, --clean` |  | Limpia la caché de paquetes descargados. Con `-R` también elimina el directorio de compilación.  
`--license` |  | Muestra la licencia de nhopkg (GPLv3+).  
`--version` |  | Muestra la versión de nhopkg y un mensaje especial si se ejecuta en un sistema LFS.  
`-h, --help` |  | Muestra esta ayuda.  
  
## Opciones comunes

Además de los comandos, nhopkg acepta varias opciones globales que modifican su comportamiento:

Opción | Descripción  
---|---  
`--no-check-deps` | Desactiva la verificación de dependencias.  
`--no-check-arch` | Desactiva la verificación de arquitectura.  
`--no-check-sha256` | Desactiva la verificación del checksum SHA256.  
`--force-check-deps` | Fuerza la verificación de dependencias (aunque esté desactivada en la configuración).  
`--verify-package-signature` | Fuerza la verificación de firmas GPG.  
`--no-verify-package-signature` | Omite la verificación de firmas GPG.  
`--sign-package` | Firma el paquete al construirlo (requiere clave GPG configurada).  
`--purge` | Al desinstalar, también elimina los paquetes que dependen del objetivo.  
`--root <dir>` | Instala el paquete en un directorio raíz alternativo (útil para chroots o imágenes).  
`-R, --recursive` | Modo recursivo: no pregunta confirmaciones (asume "sí").  
`-v, --verbose` | Modo verboso: muestra salida detallada durante compilación e instalación.  
`-o, --output <dir>` | Escribe registros de operaciones en el directorio especificado.  
  
## Ejemplos de uso
    
    
    # Instalar un paquete binario local
    sudo nhopkg -i ~/gimp-3.0.4-n2025.linux-x86_64.nho
    
    # Instalar desde repositorio
    sudo nhopkg -S gimp
    
    # Compilar e instalar desde fuente local
    sudo nhopkg -b gimp-3.0.4.srcnho
    
    # Actualizar todo el sistema
    sudo nhopkg -y
    
    # Instalar todos los paquetes del grupo "graphics"
    sudo nhopkg -G graphics
    
    # Ver información de un paquete
    nhopkg -n gimp
    
    # Listar archivos de un paquete instalado
    nhopkg -w gimp
