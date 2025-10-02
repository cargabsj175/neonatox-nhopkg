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
