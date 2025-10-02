  Nhopkg – Gestor de paquetes universal para Linux body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; line-height: 1.6; color: #333; max-width: 960px; margin: 0 auto; padding: 2rem; background-color: #fff; } h1, h2, h3 { margin-top: 1.8rem; margin-bottom: 1rem; color: #2c3e50; } h1 { border-bottom: 2px solid #3498db; padding-bottom: 0.5rem; } a { color: #2980b9; text-decoration: none; } a:hover { text-decoration: underline; } code, pre, kbd { font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, monospace; background-color: #f8f9fa; padding: 0.2em 0.4em; border-radius: 4px; font-size: 0.95em; } pre { padding: 1rem; border-radius: 6px; overflow-x: auto; background-color: #f6f8fa; border: 1px solid #e1e4e8; } table { width: 100%; border-collapse: collapse; margin: 1.2rem 0; } th, td { padding: 0.75rem; text-align: left; border: 1px solid #ddd; } th { background-color: #f1f3f5; } ul, ol { padding-left: 1.5rem; } blockquote { margin: 1rem 0; padding: 0.8rem 1.2rem; background-color: #f9f9f9; border-left: 4px solid #3498db; } .badge { display: inline-block; margin-right: 0.5rem; vertical-align: middle; } footer { margin-top: 3rem; padding-top: 1.5rem; border-top: 1px solid #eee; color: #7f8c8d; font-size: 0.9rem; }

Nhopkg – Gestor de paquetes universal para Linux
================================================

 [![License: GPLv3+](https://img.shields.io/badge/license-GPLv3%2B-blue.svg)](COPYING)[![Language: Bash](https://img.shields.io/badge/language-Bash-green.svg) ](https://www.gnu.org/software/bash/)[![Build system: Meson](https://img.shields.io/badge/build-Meson-orange.svg)](https://mesonbuild.com/)

**Nhopkg** es un gestor de paquetes universal diseñado para funcionar en cualquier distribución GNU/Linux. Utiliza paquetes binarios (`.nho`) y paquetes fuente (`.srcnho`), permitiendo crear, instalar, convertir y gestionar software de forma sencilla, consistente y portable.

Desarrollado originalmente en 2010, Nhopkg combina simplicidad, potencia y control total sobre el empaquetado, siendo especialmente útil en sistemas tipo Slackware o en entornos minimalistas.

📜 Historia y mantenimiento
---------------------------

*   **Creador original (2010):** [Jaime Gil de Sagredo Luna](https://github.com/jaimegildesagredo)
*   **Mantenimiento y evolución (2010 – presente):** [Carlos Sánchez](https://github.com/cargabsj175) para la distribución **NeonatoX**

Este proyecto ha sido mantenido activamente durante más de una década, adaptándose a nuevas herramientas, estándares y necesidades del empaquetado moderno.

🧰 Características principales
------------------------------

*   ✅ Soporte para paquetes binarios (`.nho`) y fuente (`.srcnho`)
*   ✅ Conversión automática de paquetes Slackware (`.tgz` → `.nho`)
*   ✅ Gestión avanzada de dependencias (requeridas y opcionales)
*   ✅ Compilación e instalación automática desde código fuente
*   ✅ Creación y gestión de repositorios locales
*   ✅ Internacionalización (i18n) con `gettext`
*   ✅ Integración con el sistema: MIME, iconos, esquemas, fuentes, etc.
*   ✅ Creación de paquetes desde software ya instalado (`--backup`)
*   ✅ Compatible con **cualquier distribución Linux**
*   ✅ Construcción moderna con **Meson/Ninja**

📦 Formatos de paquete
----------------------

Extensión

Tipo

Contenido

`.nho`

Paquete binario

Archivos listos para instalar, metadatos (`nhoid`) y scripts de postinstalación.

`.srcnho`

Paquete fuente

Código fuente, configuración de compilación (`nbuild`, `ninstall`) y dependencias.

🔧 Dependencias del sistema
---------------------------

Nhopkg requiere las siguientes herramientas instaladas:

Herramienta

Propósito

`bash`

Intérprete del script principal

`tar`, `zstd`

Empaquetado y compresión (Zstandard)

`sha256sum`

Verificación de integridad

`make`, `autoconf`

Compilación de paquetes fuente

`gettext`

Soporte de traducciones (opcional pero recomendado)

`ldconfig`

Actualización de caché de bibliotecas compartidas

`grep`, `awk`, `sed`, `find`

Procesamiento de texto y rutas

`wget` o `curl`

Descarga de paquetes y repositorios

`plocate` / `mlocate`

Búsqueda de archivos para resolución de dependencias

> 💡 **Recomendación**: Usa `plocate` en sistemas modernos (Arch, Fedora), o `mlocate` en Debian/Ubuntu.

🛠️ Instalación con Meson
-------------------------

Nhopkg ya no usa Autotools. Ahora se construye con **Meson**, un sistema de compilación moderno, rápido y portable.

### 1\. Requisitos previos

    # Debian / Ubuntu
    sudo apt install meson ninja-build
    
    # Arch Linux / Manjaro
    sudo pacman -S meson ninja
    
    # Fedora / RHEL
    sudo dnf install meson ninja-build
    

### 2\. Configurar el proyecto

    meson setup builddir \
      --prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      -D i18n=true \
      -D binlocate=plocate
    

> Cambia `-D binlocate=locate` si usas `mlocate` o `slocate`.

### 3\. Compilar (opcional)

    ninja -C builddir

### 4\. Instalar

    sudo ninja -C builddir install

Esto instalará:

*   `/usr/bin/nhopkg`
*   `/etc/nhopkg/nhopkg.conf`
*   `/usr/share/nhopkg/` (documentación, iconos, licencia)
*   Páginas de manual: `/usr/share/man/man8/nhopkg.8`
*   Registro MIME: `/usr/share/mime/packages/x-nho.xml`
*   Directorios en `/var/nhopkg/` (paquetes, caché, logs, base de datos)

> ⚠️ Nota: El directorio por defecto es /var/nhopkg, según `nhopkg.conf.in`.

📁 Estructura de directorios en `/var/nhopkg/`
----------------------------------------------

    /var/nhopkg/
    ├── cache/          # Paquetes descargados y temporales
    ├── files/          # Lista comprimida de archivos por paquete instalado
    ├── logs/           # Registros de compilación e instalación
    ├── packages/       # Metadatos de paquetes instalados
    └── repo/
        ├── files/      # Base de datos de archivos del repositorio
        └── packages/   # Metadatos de paquetes disponibles
    

🌐 Integración con el sistema
-----------------------------

Tras la instalación, actualiza las bases de datos del sistema:

    sudo update-mime-database /usr/share/mime
    sudo update-desktop-database /usr/share/applications  # si aplica
    

Nhopkg también ejecuta automáticamente `shooter_updates()` tras instalaciones, actualizando:

*   Esquemas GSettings
*   Caché de iconos
*   Tipos MIME
*   Fuentes
*   Manuales
*   Bibliotecas compartidas

📚 Uso básico
-------------

    # Instalar paquete local
    sudo nhopkg -i paquete-1.0-1.nho
    
    # Instalar desde repositorio
    sudo nhopkg -S nombre-del-paquete
    
    # Compilar e instalar desde fuente
    sudo nhopkg -b paquete.srcnho
    
    # Crear paquete desde software instalado
    sudo nhopkg -B nombre-del-paquete
    
    # Convertir paquete Slackware
    sudo nhopkg -z paquete.tgz
    
    # Crear repositorio local
    sudo nhopkg -g /ruta/al/repositorio
    
    # Buscar paquetes
    nhopkg -s nombre
    
    # Listar paquetes instalados
    nhopkg -l
    
    # Mostrar ayuda completa
    nhopkg --help
    

🌍 Traducciones
---------------

Nhopkg soporta múltiples idiomas gracias a `gettext`:

*   Español (`es`, `es_ES`)
*   Catalán (`ca`)
*   Francés (`fr`)
*   Ruso (`ru_RU`)
*   Portugués brasileño (`pt_BR`)

Las traducciones se gestionan con gettext. Puedes contribuir con nuevas traducciones en el directorio `po/`.

📄 Licencia
-----------

Este software está bajo la **Licencia Pública General de GNU v3 o posterior (GPL-3.0+)**.

> Nhopkg viene SIN NINGUNA GARANTÍA. Es software libre y puedes redistribuirlo bajo ciertas condiciones.  
> Ver archivo `COPYING` para más detalles.

🤝 Contribuir
-------------

¡Bienvenidos contribuidores! Puedes:

*   Reportar errores
*   Añadir traducciones
*   Mejorar el empaquetado
*   Optimizar el script

*   Proyecto original: [https://github.com/jaimegildesagredo](https://github.com/jaimegildesagredo)
*   Mantenimiento actual: [https://github.com/cargabsj175](https://github.com/cargabsj175)

📬 Contacto
-----------

*   [Jaime Gil de Sagredo Luna](https://github.com/jaimegildesagredo)
*   [Carlos Sánchez](https://github.com/cargabsj175)
*   [Web de GNU NeonatoX](https://neonatox.github.io)

**Nhopkg – Porque empaquetar debería ser fácil, universal y libre.**
