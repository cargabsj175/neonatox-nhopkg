[← Índice](README.md)

# 1\. Arquitectura general

**nhopkg** es un gestor de paquetes universal diseñado para funcionar en cualquier distribución GNU/Linux. Su arquitectura se centra en la simplicidad, portabilidad y transparencia.

## Lenguaje y compatibilidad

  * Escrito principalmente en **Bash** , pero con esfuerzo explícito por mantener compatibilidad con `sh` (por ejemplo, evitando arrays innecesarios y usando `getopt` estándar).
  * Diseñado para funcionar incluso en entornos mínimos como **BusyBox**.
  * No depende de intérpretes externos como Python, Perl o Rust.



## Formatos de paquete

nhopkg soporta dos tipos de paquetes:

  * `.nho`: paquetes binarios listos para instalar.
  * `.srcnho`: paquetes fuente que contienen recetas de compilación (`nhoid`), parches y scripts de construcción.



## Estructura de un paquete `.nho`

Un paquete binario es un archivo `tar` que contiene:

  * `nhoid`: metadatos del paquete (nombre, versión, dependencias, etc.).
  * `data.tar.zst`: archivos del software comprimidos con `zstd`.
  * `signature.gpg` (opcional): firma GPG del archivo `data.tar.zst`.



## Directorios clave

Los directorios principales utilizados por nhopkg (configurables en `/etc/nhopkg/nhopkg.conf`) son:
    
    
    NHOPKG_LOCALSTATEDIR=/var/nhopkg
    NHOPKG_BUILDIR=/usr/src/nhopkg
    NHOPKG_TRUSTED_KEYS_DIR=/etc/nhopkg/trusted-keys

  * `/var/nhopkg/packages/`: almacena los metadatos de los paquetes instalados.
  * `/var/nhopkg/files/`: contiene listas comprimidas de archivos instalados por cada paquete.
  * `/var/nhopkg/repo/`: caché local de los repositorios sincronizados.
  * `/var/nhopkg/cache/`: paquetes descargados temporalmente.
  * `/var/nhopkg/logs/`: registros de compilación e instalación.



## Portabilidad y minimalismo

nhopkg fue concebido para ser utilizado en:

  * Distribuciones personalizadas (LFS, BLFS).
  * Sistemas embebidos o de recursos limitados.
  * Entornos de producción donde la reproducibilidad y el control total son prioritarios.



Gracias a su diseño modular y su bajo acoplamiento con el sistema base, puede integrarse fácilmente en cualquier entorno Linux sin imponer requisitos complejos.
