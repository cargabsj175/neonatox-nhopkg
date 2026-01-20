[← Índice](index.md)

# 3\. Formato del paquete: `nhoid`

El archivo `nhoid` es el núcleo de cualquier paquete **nhopkg**. Define metadatos, dependencias, fuentes y comportamiento.

Existen dos tipos de paquetes, y sus `nhoid` son fundamentalmente distintos:

  * **Paquetes fuente** (`.srcnho`): contienen recetas para compilar e instalar software.
  * **Paquetes binarios** (`.nho`): contienen archivos listos para instalar en el sistema.



## Estructura común

Todos los `nhoid` deben comenzar con la versión del formato:
    
    
    #%NHO-0.5

Cada línea sigue el patrón: `# NombreDelCampo: <valor>` (usando un tabulador después de los dos puntos).

## Campos comunes a ambos tipos

Campo | Descripción | Obligatorio  
---|---|---  
`# Name:` | Nombre del paquete (solo letras, números, guiones y guiones bajos). | Sí  
`# Version:` | Versión del software (sin el número de release). | Sí  
`# Release:` | Número de release del paquete (ej. `n2025`). | Sí  
`# Description:` | Descripción breve del paquete. | Sí  
`# Package Maintainer:` | Correo del mantenedor. | No  
`# License:` | Licencia del software. | No  
`# Url:` | Sitio web oficial del proyecto. | No  
`# Group:` | Grupo lógico (para instalación por grupos). | No  
`# Repository:` | Repositorio destino (ej. `extra`, `multilib`). | No  
`# Arch:` | Arquitectura objetivo. Usa `noarch`, `all` o `any` si es independiente. | No (pero recomendado)  
`# Dep(post):` | Dependencias en tiempo de ejecución (con operadores de versión opcionales). | No  
`# OptionalDep(post):` | Dependencias opcionales en tiempo de ejecución. | No  
`# Provides:` | Interfaces o nombres virtuales que este paquete satisface. | No  
`# Conflicts:` | Paquetes incompatibles (con operadores de versión). | No  
`# Splitpackage:` | Lista de subpaquetes (ej. `dev docs`). | No  
  
## Paquetes fuente (`.srcnho`)

Estos paquetes contienen la receta para construir software. Pueden usar **Git** o **tarball** como fuente.

### Opción A: Fuente Git

**Regla:** Si se usa Git, **no se incluye** archivo fuente ni `SHA256`. 

Campo | Descripción | Obligatorio  
---|---|---  
`# Packageurl:` | URL del repositorio Git (debe empezar con `git+` o terminar en `.git`). | Sí  
`# Packageref:` | Referencia Git (tag, rama o commit). | Sí  
  
Ejemplo: `git+https://gitlab.gnome.org/GNOME/gimp.git` \+ `GIMP_3_0_4`

### Opción B: Tarball (local o remoto)

**Regla:** Si se usa tarball (ya sea embebido en el `.srcnho` o descargado), **el campo`SHA256` es obligatorio** y corresponde al hash del archivo fuente. 

Campo | Descripción | Obligatorio  
---|---|---  
`# Packageurl:` | URL del tarball (si es remoto) o nombre del archivo dentro del `.srcnho` (si es local). | Sí  
`# SHA256:` | Checksum SHA256 del archivo fuente (tarball). | Sí  
  
### Dependencias de construcción (solo en fuente)

Campo | Descripción | Obligatorio  
---|---|---  
`# BuildDep:` | Dependencias requeridas para compilar. | No  
`# OptionalBuildDep:` | Dependencias opcionales para compilar. | No  
  
## Paquetes binarios (`.nho`)

**Reglas clave:**

  * **Nunca** contienen `Packageurl`, `Packageref`, ni archivos fuente.
  * **Siempre** incluyen el campo `SHA256`, que corresponde al hash de `data.tar.zst`.
  * **Siempre** incluyen los campos técnicos de construcción.



### Campos exclusivos de binarios

Campo | Descripción | Obligatorio  
---|---|---  
`# OS:` | Sistema operativo (normalmente `linux`). | Sí  
`# Installed-Size:` | Tamaño estimado en KB del paquete instalado. | Sí  
`# Build-Duration:` | Tiempo de compilación en segundos. | Sí  
`# Build-Date:` | Fecha y hora de construcción (formato ISO). | Sí  
`# Build-Host:` | Nombre del host donde se construyó. | Sí  
`# SHA256:` | Checksum SHA256 de `data.tar.zst`. | Sí  
  
## Funciones de post-instalación/eliminación

Ambos tipos pueden incluir funciones Bash (definidas al final del archivo):

  * `nbuild()`: solo en paquetes fuente.
  * `ninstall()`: solo en paquetes fuente.
  * `npostinstall()`: se ejecuta tras instalar (ambos tipos, pero más común en binarios).
  * `npostremove()`: se ejecuta tras desinstalar.



Para subpaquetes, se usan sufijos: `npostinstall_dev()`, etc.

## Ejemplo: paquete fuente (Git)
    
    
    #%NHO-0.5
    # Name:			greetd
    # Version:		0.9.0
    # Release:		n2025
    # Description:		Lightweight display manager
    # Packageurl:		git+https://git.sr.ht/~kennylevinsen/greetd
    # Packageref:		v0.9.0
    # Dep(post):		pam systemd
    # BuildDep:		meson>=0.56 ninja
    
    nbuild() {
      meson setup build --prefix=/usr
      ninja -C build
    }

## Ejemplo: paquete binario
    
    
    #%NHO-0.5
    # Name:			greetd
    # Version:		0.9.0
    # Release:		n2025
    # Description:		Lightweight display manager
    # Arch:			x86_64
    # OS:			linux
    # Installed-Size:	1200 KB
    # Build-Duration:	45
    # Build-Date:		2026-01-14T10:30:00Z
    # Build-Host:		buildhost.local
    # SHA256:		a1b2c3d4e5f6...
    # Dep(post):		pam systemd
    # Repository:		extra
