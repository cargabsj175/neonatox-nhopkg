[← Índice](index.md)

# 13\. Próximos pasos

Aunque **nhopkg v0.5.1** ya es funcional y apto para producción, hay varias áreas donde puede mejorarse. Esta sección ofrece una hoja de ruta para contribuyentes, mantenedores de paquetes y usuarios avanzados.

## 13.1. Para mantenedores de paquetes

### Crear un paquete fuente (`.srcnho`)

  1. Crea un directorio con el nombre del paquete y versión: `gimp-3.0.4/`.
  2. Dentro, incluye: 
     * `nhoid`: metadatos y funciones de compilación.
     * `patches/` (opcional): parches a aplicar.
     * `others/` (opcional): scripts adicionales o archivos de configuración.
  3. Empaqueta con: `tar cp gimp-3.0.4/ | zstd > gimp-3.0.4.srcnho`.



### Ejemplo mínimo de `nhoid`
    
    
    #%NHO-0.5
    # Name:			hello
    # Version:		2.10
    # Release:		n2025
    # Description:		The classic GNU Hello program
    # Packageurl:		https://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz
    # SHA256:		a1b2c3...
    
    nbuild() {
      ./configure --prefix=/usr
      make
    }
    
    ninstall() {
      DESTDIR="${NHOPKG_TMPDIR}" make install
    }

## 13.2. Para desarrolladores del gestor

### Hoja de ruta técnica (v0.6+)

  * **Pruebas automatizadas** : suite de tests unitarios e integración (usando `bats` o similar).
  * **Man pages** : generar documentación en formato `man(7)` desde la ayuda actual.
  * **Soporte para deltas** : implementar descargas incrementales (ej. con `zsync`).
  * **Modo sandbox** : ejecutar `nbuild()` en un entorno aislado (chroot, user namespaces).
  * **API de scripting** : permitir que otros scripts usen funciones de nhopkg como librería.
  * **Soporte para mirrors activos** : probar conectividad antes de usar un mirror.



## 13.3. Para distribuciones personalizadas

### Flujo recomendado de despliegue

  1. Define tus repositorios en `/etc/nhopkg/nhopkg.conf`.
  2. Organiza tus paquetes en grupos lógicos: `base`, `xorg`, `desktop`, etc.
  3. Usa `--create-repo` para generar metadatos automáticamente.
  4. Instala con `--install-group base` para sistemas mínimos.
  5. Habilita firmas GPG obligatorias en entornos críticos.



## 13.4. Contribuir al proyecto

nhopkg es software libre (GPLv3+). Puedes contribuir de varias formas:

  * Reportando errores en el repositorio oficial.
  * Enviando parches para mejorar compatibilidad con `sh` o `busybox`.
  * Documentando recetas de empaquetado para software popular.
  * Traduciendo mensajes con `gettext`.



## 13.5. Recursos útiles

Recurso | Descripción  
---|---  
`nhopkg --help` | Ayuda completa en línea de comandos.  
`/usr/share/nhopkg/nhopkg.conf` | Archivo de configuración por defecto.  
`/var/nhopkg/logs/` | Registros de compilación e instalación.  
[Beyond Linux From Scratch](https://linuxfromscratch.org/blfs/) | Referencia para usuarios/grupos y unidades de servicio.  
  
## Conclusión

**nhopkg** no solo es un gestor de paquetes, sino una base sólida para construir sistemas Linux controlados, reproducibles y seguros. Los próximos pasos dependen de tu rol: como usuario, mantenedor o desarrollador, hay espacio para crecer junto con este proyecto.
