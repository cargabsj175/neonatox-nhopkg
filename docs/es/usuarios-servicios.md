[← Índice](README.md)

# 6\. Gestión de usuarios y servicios

**nhopkg** incluye dos funciones esenciales para la gestión de sistemas de producción:

  * `nhouser()`: crea o verifica usuarios y grupos del sistema de forma idempotente.
  * `install_init_unit()`: instala unidades de servicio para `systemd` o scripts de `sysvinit` desde fuentes externas (como BLFS).



Ambas funciones están diseñadas para integrarse en los scripts de post-instalación (`npostinstall()`) de los paquetes, siguiendo las convenciones de **Beyond Linux From Scratch (BLFS)**.

## 6.1. Gestión de usuarios y grupos: `nhouser()`

La función `nhouser` permite crear cuentas de sistema de forma segura, repetible y compatible con BLFS. Es idempotente: si el usuario ya existe, no falla ni lo modifica.

### Sintaxis
    
    
    nhouser --check|--create [opciones]

### Opciones disponibles

Opción | Descripción  
---|---  
`--check`| Verifica si el usuario/grupo existe (no crea nada).  
`--create`| Crea el usuario/grupo si no existe.  
`--user <nombre>`| Nombre del usuario a crear.  
`--group <nombre>`| Nombre del grupo primario.  
`--uid <id>`| ID numérico del usuario (recomendado en BLFS).  
`--gid <id>`| ID numérico del grupo.  
`--shell <ruta>`| Shell asignado (ej. `/bin/false`, `/sbin/nologin`).  
`--groups <lista>`| Grupos secundarios (separados por comas).  
  
### Ejemplos reales (BLFS)

Estos ejemplos replican exactamente lo que se hace en BLFS para paquetes comunes.

#### Ejemplo 1: Usuario para `cups`
    
    
    nhouser --create \
      --user lp \
      --group lp \
      --uid 9 \
      --gid 9 \
      --shell /sbin/nologin

#### Ejemplo 2: Usuario para `greetd`
    
    
    nhouser --create \
      --user greetd \
      --group greetd \
      --uid 51 \
      --gid 51 \
      --shell /sbin/nologin

#### Ejemplo 3: Usuario para `dhcpcd`
    
    
    nhouser --create \
      --user dhcp \
      --group dhcp \
      --uid 82 \
      --gid 82 \
      --shell /sbin/nologin

**Nota:** Los UID/GID utilizados aquí coinciden con los estándares de BLFS y LFS, garantizando compatibilidad con scripts y políticas de seguridad existentes. 

## 6.2. Gestión de servicios: `install_init_unit()`

Esta función instala unidades de servicio desde repositorios externos de BLFS, detectando automáticamente si el sistema usa `systemd` o `sysvinit`.

### Sintaxis
    
    
    install_init_unit install|remove <servicio>

### Variables requeridas

El sistema debe definir en su configuración global:

  * `INITSYSTEM`: `systemd` o `sysvinit`
  * `SYSTEMD_BLFS_URL` y `SYSTEMD_BLFS_DIR`
  * `SYSV_BLFS_URL` y `SYSV_BLFS_DIR`



### Ejemplos reales (BLFS)

#### Ejemplo 1: Instalar unidad de `slapd` (OpenLDAP)
    
    
    install_init_unit install slapd

Esto descargará e instalará la unidad desde el repositorio de BLFS para systemd o el script de sysvinit, según corresponda.

#### Ejemplo 2: Eliminar unidad de `cups`
    
    
    install_init_unit remove cups

#### Ejemplo 3: Integración en `npostinstall()`
    
    
    npostinstall() {
      # Crear usuario
      nhouser --create --user lp --group lp --uid 9 --gid 9 --shell /sbin/nologin
    
      # Instalar servicio
      install_init_unit install cups
    
      # Recargar systemd (si aplica)
      [ -x /usr/bin/systemctl ] && systemctl daemon-reload
    }

## 6.3. Configuración del sistema

Para que `install_init_unit()` funcione, tu sistema debe definir variables como:
    
    
    # En /etc/profile.d/nhopkg-init.sh o similar
    export INITSYSTEM="systemd"
    export SYSTEMD_BLFS_URL="https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-systemd-20250101.tar.xz"
    export SYSTEMD_BLFS_DIR="/usr/src/blfs-bootscripts-systemd"
    export SYSV_BLFS_URL="https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-20250101.tar.xz"
    export SYSV_BLFS_DIR="/usr/src/blfs-bootscripts"

La primera vez que se use, `install_init_unit` descargará y descomprimirá el archivo correspondiente en el directorio indicado.

## Conclusión

Con `nhouser()` e `install_init_unit()`, **nhopkg** ofrece una solución madura y alineada con BLFS para gestionar aspectos críticos de los paquetes en entornos de producción, sin depender de herramientas externas complejas.
