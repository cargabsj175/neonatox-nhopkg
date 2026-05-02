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

### 13. Resolver entradas fuzzy en traducciones ⏳
- **Problema**: Tras regenerar correctamente `nhopkg.pot`, todas las entradas en `.po` quedaron como fuzzy (505 total).
- **Por qué**: El `.pot` anterior estaba corrupto/desactualizado, por lo que las traducciones existentes no coincidían.
- **Cómo conseguirlo**:
  1. Ejecutar: `./scripts/update-translations.sh`
  2. Revisar cada `.po` y validar que las traducciones sean correctas
  3. Eliminar marca `#, fuzzy` de cada entrada revisada
  4. Prioridad: `es.po` (idioma principal), luego `fr.po`, `ca.po`, `pt_BR.po`, `ru_RU.po`
- **Nota**: Las traducciones son válidas pero necesitan revisión manual contra el nuevo template.

### 14. Actualizar README.md a inglés como idioma principal ✅
- **Qué se hizo**: README.md ahora está en inglés como idioma principal, con enlaces a docs en español y portugués brasileño.
- **Cambios**:
  - README.md principal en inglés
  - docs/es/README.md mantiene documentación en español
  - docs/pt_BR/README.md creado como índice en portugués (enlaces a docs en español)

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

---

# PLAN DE TRADUCCIONES (i18n/gettext)

## Estado Actual del Sistema

### Arquitectura
- **Framework**: gettext con `echog()` / `echogn()` wrappers en `src/libnhopkg.in`
- **TEXTDOMAIN**: `nhopkg` (definido en `src/nhopkg.conf.in`)
- **TEXTDOMAINDIR**: `/usr/share/locale` (definido en `src/libnhopkg.in`)
- **Idiomas**: ca, es, es_ES, fr, pt_BR, ru_RU
- **Build**: Meson compila `.po` → `.mo` vía `i18n.gettext()`
- **Actualización**: `meson compile update-translations -C builddir` o `scripts/update-translations.sh`

### Problemas Detectados

| # | Severidad | Problema | Impacto |
|---|-----------|----------|---------|
| 1 | ~~CRÍTICO~~ | ~~Flags inválidos `gettext -es` y `gettext -ens`~~ | ~~RESUELTO~~ |
| 2 | ~~ALTO~~ | ~~`nhopkg.pot` sin generar correctamente~~ | ~~RESUELTO~~ |
| 3 | ~~ALTO~~ | ~~Sin flujo xgettext automático~~ | ~~RESUELTO~~ |
| 4 | **MEDIO** | Entradas fuzzy en `.po` tras regeneración | Traducciones pendientes de revisión |
| 5 | **MEDIO** | `es.po` y `es_ES.po` son redundantes | Mantenimiento duplicado |
| 6 | **BAJO** | `libnhopkg.in` no se incluye en xgettext (no es ejecutable directo) | Funciona correctamente (xgettext procesa cualquier archivo shell) |

---

## Plan de Solución (Fases)

### FASE 1: ~~Corregir errores críticos~~ ✅ COMPLETADO

#### ~~1.1 Corregir flags de gettext en `echog()` / `echogn()`~~ ✅
- **Estado**: Completado (commit `cc1be8b`)
- **Cambio**: `gettext -es` → `gettext -e`, `gettext -ens` → `gettext -en`

#### ~~1.2 Generar `nhopkg.pot` correctamente~~ ✅
- **Estado**: Completado (commit `cc1be8b`)
- **Resultado**: 257 strings extraídas correctamente

---

### FASE 2: ~~Automatizar flujo de traducciones con Meson~~ ✅ COMPLETADO

#### ~~2.1 Crear script `scripts/update-translations.sh`~~ ✅
- **Estado**: Completado (commit `1947991`)
- **Funcionalidades**:
  - Extracción automática con xgettext
  - Actualización de `.po` con msgmerge
  - Soporte para `--new-lang` para crear nuevos idiomas
  - Reporte de fuzzy entries y resumen

#### ~~2.2 Integrar con Meson como `run_target`~~ ✅
- **Estado**: Completado (commit `1947991`)
- **Uso**: `meson compile update-translations -C builddir`
- **Flujo**: Detecta `MESON_SOURCE_ROOT` para rutas correctas

---

### FASE 3: Limpieza y mantenimiento (PENDIENTE)

#### 3.1 Resolver entradas fuzzy
- **fr.po**: ~87 entradas fuzzy
- **ca.po**: ~86 entradas fuzzy
- **es.po/es_ES.po/pt_BR.po/ru_RU.po**: ~83 entradas fuzzy cada uno
- **Acción**: Revisar cada entrada, validar traducción, quitar marca `#, fuzzy`
- **Herramienta**: `grep -n '^#, fuzzy' po/*.po` para localizar

#### 3.2 Unificar `es.po` y `es_ES.po`
- **Problema**: Dos archivos idénticos para el mismo idioma
- **Solución**: Quedarse con `es.po` (código estándar), eliminar `es_ES.po`
- **Actualizar**: `po/meson.build` para quitar `es_ES` de la lista

#### 3.3 Añadir validación de sintaxis al build
- **Qué**: Verificar `.po` antes de compilar a `.mo`
- **Cómo**: `msgfmt --check` se ejecuta automáticamente en Meson

---

### FASE 4: Mejoras a largo plazo (PENDIENTE)

#### 4.1 Soporte para nuevos idiomas
- **Proceso**: `scripts/update-translations.sh --new-lang XX`
- **Integrar**: Añadir `XX` a la lista en `po/meson.build`

#### 4.2 CI/CD para traducciones
- **Qué**: Validar traducciones en CI (sintaxis, consistencia)
- **Cómo**:
  ```yaml
  # .github/workflows/i18n.yml
  - run: msgfmt --check -o /dev/null po/*.po
  - run: msgfmt --statistics po/*.po
  ```

#### 4.3 Documentar proceso de traducción
- **Archivo**: `docs/i18n.md` con flujo recomendado

---

## Resumen de Acciones Requeridas

| Prioridad | Acción | Complejidad | Impacto | Estado |
|-----------|--------|-------------|---------|--------|
| ~~CRÍTICO~~ | ~~Corregir `gettext -es` → `gettext -e`~~ | ~~5 min~~ | ~~Todas las traducciones~~ | ✅ |
| ~~ALTO~~ | ~~Regenerar `.pot` con xgettext~~ | ~~15 min~~ | ~~Flujo de actualización~~ | ✅ |
| ~~ALTO~~ | ~~Crear script update-translations.sh~~ | ~~30 min~~ | ~~Automatización~~ | ✅ |
| ~~ALTO~~ | ~~Integrar script con Meson (run_target)~~ | ~~20 min~~ | ~~Developer UX~~ | ✅ |
| **MEDIO** | Limpiar fuzzy entries (todos) | 2-4 horas | Calidad traducciones | ⏳ |
| **MEDIO** | Unificar es.po/es_ES.po | 10 min | Limpieza | ⏳ |
| **BAJO** | Documentar proceso i18n | 1 hora | Contribuidores | ⏳ |
