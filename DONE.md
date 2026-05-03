# DONE.md - Tareas Completadas

## nhouser() - Correcciones (2025)

| # | Tarea | Commit | Detalle |
|---|-------|--------|---------|
| 1 | Reparar modo verbose roto | - | `nhouser()` no activaba verbose correctamente |
| 2 | Restaurar resolución de conflictos UID/GID | - | Nuevos usuarios/grupos con IDs en conflicto ahora se resuelven |
| 3 | Restaurar comportamiento de directorio home | - | `useradd -M` para nuevos usuarios |
| 4 | Restaurar advertencias de coincidencia UID/GID | - | Advertencias informativas para usuarios/grupos existentes |
| 5 | Eliminar lógica redundante de creación de grupos | - | Eliminada verificación doble de grupos |
| 6 | Uso consistente de `echog` para i18n | - | `nhouser.in` usa `echog()` en lugar de `echo` directo |

## Dependencias - Reescritura (2025)

| # | Tarea | Commit | Detalle |
|---|-------|--------|---------|
| 7 | Reescribir `upgrade` con Unified Dependency Resolution System | - | Resolución global → por paquete |
| 8 | Reescribir `install-group` con Unified Dependency Resolution System | - | Mismo patrón que `upgrade` |
| 9 | Instalación individual por paquete | - | Cada paquete se procesa: descargar → resolver deps → instalar → continuar |

### Beneficios de la reescritura:
- Mejor manejo de errores (falla un paquete, continúa con los demás)
- Dependencias resueltas en contexto (no globalmente)
- Salta dependencias ya instaladas si versión coincide/es mayor
- Consistencia con instalación individual (`-i`, `-S`)

## i18n/gettext - Corrección y Automatización (2025-05)

| # | Tarea | Commit | Detalle |
|---|-------|--------|---------|
| 13 | Corregir flags de gettext | `cc1be8b` | `gettext -es` → `gettext -e`, `gettext -ens` → `gettext -en` |
| - | Generar `nhopkg.pot` correctamente | `cc1be8b` | 257 strings extraídas con xgettext |
| - | Crear script `update-translations.sh` | `1947991` | Extracción automática, msgmerge, soporte `--new-lang` |
| - | Integrar con Meson como `run_target` | `1947991` | `meson compile update-translations -C builddir` |
| - | Resolver entradas fuzzy | `118da64` | 6 idiomas actualizados, fuzzy eliminados (excepto 3 ca, 4 fr) |
| - | Corregir bug en script de traducciones | `118da64` | Conteo de fuzzy con `tr -d '[:space:]'` |
| - | Añadir `*.po~` a `.gitignore` | - | Archivos temporales de editores ignorados |

### Estado de traducciones:
| Idioma | Strings | Fuzzy | Vacías |
|--------|---------|-------|--------|
| ca | 257 | 3 | ~72 |
| es | 257 | 0 | ~1 |
| es_ES | 257 | 0 | ~141 |
| fr | 257 | 4 | ~65 |
| pt_BR | 257 | 0 | ~67 |
| ru_RU | 257 | 0 | ~65 |

## Documentación

| # | Tarea | Commit | Detalle |
|---|-------|--------|---------|
| 14 | README.md en inglés como idioma principal | `f816bf7` | Enlaces a docs/es/ y docs/pt_BR/ |
| - | Crear `docs/pt_BR/README.md` | `f816bf7` | Índice en portugués brasileño |
| - | Crear `AGENTS.md` | - | Guía compacta de desarrollo |

## Otros

| # | Tarea | Detalle |
|---|-------|---------|
| - | Fix bash reserved variable `GROUPS` | Cambiado a `ADDITIONAL_GROUPS` en `nhouser()` |
| - | Fix falso positivo en resolución de dependencias | Validación estricta de nombres nhoid en `_dep_find_in_repos()` |
| - | Remover check estricto de overlay en `/proc/filesystems` | `nhopkg-overlay.in` ahora deja que `mount` falle naturalmente |
