i18n = import('i18n')

i18n.gettext(meson.project_name(),
  languages: ['ca', 'es', 'fr', 'pt_BR', 'ru_RU']
)

# Run target to update translations: meson compile update-translations -C builddir
if xgettext_prog.found() and msgmerge_prog.found()
  run_target('update-translations',
    command: [find_program('bash'), meson.project_source_root() / 'scripts' / 'update-translations.sh']
  )
else
  message('i18n tools (xgettext, msgmerge) not found. Target "update-translations" disabled.')
endif
