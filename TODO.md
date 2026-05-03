# TODO.md - Tareas Pendientes

## Mejoras a Corto Plazo

### 1. Unificar `es.po` y `es_ES.po` ⏳
- **Problema**: Dos archivos idénticos para el mismo idioma.
- **Solución**: Quedarse con `es.po` (código estándar), eliminar `es_ES.po`.
- **Actualizar**: `po/meson.build` para quitar `es_ES` de la lista.

### 2. Resolver fuzzy restantes ⏳
- **ca.po**: 3 entradas fuzzy
- **fr.po**: 4 entradas fuzzy
- **Herramienta**: Poedit, gtranslator o Lokalize

### 3. Validación de grupos en `install-group` ⏳
- **Qué corregir**: La validación de grupos (que no empiecen con `-` o `--`) usa un `case` que podría no capturar todos los casos.
- **Archivo**: `src/nhopkg.in:4528`

---

## Mejoras a Mediano Plazo

### 4. Añadir verificación de privilegios root en `nhouser` ⏳
- **Qué corregir**: `nhouser` requiere root para crear usuarios/grupos, pero no lo verifica antes de operar.
- **Cómo**: Añadir al inicio de `nhouser()`:
```bash
if [[ $EUID -ne 0 ]]; then echo "Requires root privileges" >&2; return 1; fi
```
- **Archivo**: `src/libnhopkg.in:807`

### 5. Limpieza ante fallos parciales en `nhouser` ⏳
- **Qué corregir**: Si se crea un grupo pero falla la creación del usuario, el grupo queda huérfano.
- **Cómo**: Rastrear grupos/usuarios creados y eliminarlos si una operación posterior falla:
```bash
local CREATED_GROUP=0 CREATED_USER=0
# Después de groupadd/useradd exitoso: CREATED_GROUP=1 / CREATED_USER=1
# En caso de error:
if [ "$CREATED_GROUP" = 1 ] && [ "$CREATED_USER" = 0 ]; then
    groupdel "$GNAME" 2>/dev/null
fi
```

### 6. Inconsistencia `REPLACES_PACKAGE` vs `DEP_REPLACE_PACKAGE` ⏳
- **Qué corregir**: En `install-group` original se usaba `REPLACES_PACKAGE`, en la nueva versión `DEP_REPLACE_PACKAGE`.
- **Cómo**: Verificar si `REPLACES_PACKAGE` se usa en otro lado. Si sí, añadir compatibilidad.
- **Archivo**: `src/nhopkg.in:4603`

---

## Metas a Largo Plazo (Nhopkg 0.6+)

### 10. Funcionalidades del TODO original

| Meta | Descripción |
|------|-------------|
| **Auto-package** | Buscar dependencias automáticamente desde `configure.ac` o similar |
| **Build más rápido** | Reducir tiempo para crear paquetes binarios |
| **Config local** | Soporte para archivo de configuración local (`~/.nhopkg/nhopkg.conf`) |
| **Barra de progreso** | Barra de progreso para descargas (sin depender de wget) |
| **Conflictos** | Opción para agregar paquetes en conflicto manualmente |
| **Búsqueda avanzada** | Buscar paquetes huérfanos, obsoletos y nuevos disponibles |
| **rpm2nho** | Convertir paquetes RPM a formato Nhopkg |
| **deb2nho** | Convertir paquetes DEB a formato Nhopkg |
| **PKGBUILD2nhoid** | Convertir PKGBUILD de Arch Linux a formato nhoid |

---

### 11. Centralizar patrón de parseo de argumentos ⏳
- **Qué corregir**: Múltiples scripts implementan parseo manual de argumentos con `while/case`.
- **Cómo**: Crear función auxiliar para parseo de opciones largas en `libnhopkg.in`:
```bash
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

### 12. CI/CD para traducciones ⏳
- **Qué**: Validar traducciones en CI (sintaxis, consistencia).
- **Cómo**:
```yaml
# .github/workflows/i18n.yml
- run: msgfmt --check -o /dev/null po/*.po
- run: msgfmt --statistics po/*.po
```

### 13. Documentar proceso de traducción ⏳
- **Archivo**: `docs/i18n.md` con flujo recomendado para contribuidores.

---

## Problemas Resueltos (No requieren acción)

### Uso de `DCASEPACKAGES` no documentado
- **Estado**: ELIMINADO - Ya no se usa en las versiones nuevas (instalación individual por paquete).
