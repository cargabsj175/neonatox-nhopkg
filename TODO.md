# TODO.md - Tareas de Desarrollo Nhopkg

## ✅ Completado
### 1. Reparar modo verbose roto en `nhouser()` - COMPLETADO
### 2. Restaurar resolución de conflictos UID/GID para nuevos usuarios/grupos - COMPLETADO
### 3. Restaurar comportamiento de directorio home para nuevos usuarios - COMPLETADO (useradd -M)
### 4. Restaurar advertencias de coincidencia UID/GID para usuarios/grupos existentes - COMPLETADO
### 5. Eliminar lógica redundante de creación de grupos - COMPLETADO (eliminada verificación doble)
### 6. Uso consistente de `echog` para i18n en `nhouser.in` - COMPLETADO
### 7. Reescribir caso `upgrade` usando Unified Dependency Resolution System - COMPLETADO
### 8. Reescribir caso `install-group` usando Unified Dependency Resolution System - COMPLETADO
### 9. Cambiar `upgrade` e `install-group` a instalación individual por paquete - COMPLETADO

## Mejoras Pendientes

### 10. Añadir verificación de privilegios root en `nhouser` ⏳
- **Qué corregir**: `nhouser` requiere root para crear usuarios/grupos, pero no lo verifica antes de operar.
- **Por qué**: Evitar errores confusos de `groupadd`/`useradd` sin permisos.
- **Cómo conseguirlo**: Añadir al inicio de `nhouser()`: `if [[ $EUID -ne 0 ]]; then echo "Requires root privileges" >&2; return 1; fi`
- **Archivo**: `src/libnhopkg.in:807` (después de `local GROUP_DONE=0`)

### 11. Limpieza ante fallos parciales ⏳
- **Qué corregir**: Si se crea un grupo pero falla la creación del usuario, el grupo queda huérfano.
- **Por qué**: Falta lógica de rollback para operaciones parciales.
- **Cómo conseguirlo**: Rastrear grupos/usuarios creados y eliminarlos si una operación posterior falla (solo modo `--create`).
- **Código sugerido**:
```bash
local CREATED_GROUP=0 CREATED_USER=0

# Después de groupadd exitoso:
CREATED_GROUP=1

# Después de useradd exitoso:
CREATED_USER=1

# Al final, antes de return 1 en errores:
if [ "$CREATED_GROUP" = 1 ] && [ "$CREATED_USER" = 0 ]; then
    groupdel "$GNAME" 2>/dev/null
fi
```

### 12. Centralizar patrón de parseo de argumentos ⏳
- **Qué corregir**: Múltiples scripts implementan parseo manual de argumentos con `while/case`.
- **Por qué**: Reducir duplicación, hacer el parseo más consistente.
- **Cómo conseguirlo**: Crear función auxiliar para parseo de opciones largas en `libnhopkg.in`, reutilizable por todos los scripts.
- **Ejemplo de interfaz**:
```bash
# En libnhopkg.in
parse_common_args() {
    local -n _args_map=$1
    shift
    while [ $# -gt 0 ]; do
        case "$1" in
            --*) _args_map["${1#--}"]="$2"; shift 2 ;;
            *) return 1 ;;
        esac
    done
}
```

## Problemas Detectados en `upgrade` e `install-group` (Reescritura)

### 13. Uso de `DCASEPACKAGES` no documentado ⏳
- **Qué corregir**: Tras reescribir `upgrade` e `install-group` usando Unified Dependency Resolution System, se usa `DCASEPACKAGES=()` para limpiar la cola, pero esta variable es interna de `_dep_download_all()`.
- **Por qué**: Posible conflicto con otras funciones que usen esta variable global.
- **Cómo conseguirlo**: Usar `unset DCASEPACKAGES` en lugar de asignar array vacío, o documentar el uso de esta variable global.
- **Estado**: ELIMINADO - Ya no se usa en las versiones nuevas (instalación individual por paquete).

### 14. Inconsistencia en nombre de variable `REPLACES_PACKAGE` vs `DEP_REPLACE_PACKAGE` ⏳
- **Qué corregir**: En `install-group` original se usaba `REPLACES_PACKAGE`, en la nueva versión se usa `DEP_REPLACE_PACKAGE` (del Unified System).
- **Por qué**: Si hay código legacy que dependa de `REPLACES_PACKAGE`, podría fallar.
- **Cómo conseguirlo**: Verificar si `REPLACES_PACKAGE` se usa en otro lado. Si no, mantener `DEP_REPLACE_PACKAGE`. Si sí, añadir compatibilidad: `REPLACES_PACKAGE="$DEP_REPLACE_PACKAGE"`.
- **Archivo**: `src/nhopkg.in:4603`

### 15. Validación de grupos en `install-group` ⏳
- **Qué corregir**: La validación de grupos (que no empiecen con `-` o `--`) usa un `case` que podría no capturar todos los casos inválidos.
- **Por qué**: Nombres de grupos que empiecen con `-` son inválidos pero el patrón `--*|-*` podría no ser suficiente.
- **Cómo conseguirlo**: Usar una validación más robusta: `if [[ "$GROUP" == -* ]]; then ...`
- **Archivo**: `src/nhopkg.in:4528`

## Notas de la Reescritura (upgrade e install-group)

### Cambio a Instalación Individual por Paquete
- **Problema original**: Las versiones anteriores resolvían todas las dependencias globalmente y luego instalaban todos los paquetes. Esto causaba problemas si un paquete en el medio fallaba.
- **Solución implementada**: Ahora cada paquete se procesa individualmente:
  1. Descargar paquete
  2. Extraer nhoid
  3. Resolver dependencias de ese paquete (con `dep_resolve_from_nhoid`)
  4. Instalar dependencias (con `dep_install_queue`)
  5. Verificar conflictos (`dep_check_conflicts`)
  6. Instalar el paquete
- **Beneficios**:
  - Mejor manejo de errores (falla un paquete, continúa con los demás)
  - Dependencias resueltas en contexto (no globalmente)
  - Consistencia con instalación individual (`-i`, `-S`)
